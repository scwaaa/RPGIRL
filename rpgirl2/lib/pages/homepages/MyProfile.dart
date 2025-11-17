// MyProfile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/config/auth_service.dart';
import 'package:rpgirl2/models/user_model.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Map<String, Map<String, dynamic>> _achievementDetails = {};
  bool _isLoadingAchievements = false;

  @override
  void initState() {
    super.initState();
    _loadAchievementDetails();
  }

  Future<void> _loadAchievementDetails() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    
    if (user != null && user.badges.isNotEmpty) {
      setState(() {
        _isLoadingAchievements = true;
      });
      
      try {
        for (String badgeId in user.badges) {
          final details = await authService.getAchievementDetails(badgeId);
          _achievementDetails[badgeId] = details;
        }
      } catch (e) {
        print('Error loading achievement details: $e');
      } finally {
        setState(() {
          _isLoadingAchievements = false;
        });
      }
    }
  }

  void _showAchievementPopup(Map<String, dynamic> achievement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            achievement['name'] ?? 'Achievement',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFAE69D5),
            ),
          ),
          content: Text(
            achievement['description'] ?? 'No description available.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFFAE69D5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int current, int max, Color color) {
    final progress = max > 0 ? current / max : 0.0;
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '$current/$max',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color(0xFFAE69D5),
              ),
              SizedBox(height: 16),
              Text(
                'Loading profile...',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFAE69D5).withOpacity(0.8),
                      Color(0xFF8a0ad5).withOpacity(0.6),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            color: user.isEmailVerified ? Colors.green : Colors.orange,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            user.isEmailVerified ? 'Verified' : 'Unverified',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content Section
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Level and Stats
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Labels and Teams Chips - Centered
                          if (user.labels.isNotEmpty || user.teams.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center, // Center the chips
                                    children: [
                                      // Teams chips with special styling
                                      ...user.teams.map((team) => Chip(
                                        label: Text(
                                          team,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Color(0xFFAE69D5),
                                        side: BorderSide.none,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      )).toList(),
                                      
                                      // Labels chips with different styling
                                      ...user.labels.map((label) => Chip(
                                        label: Text(
                                          label,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFAE69D5),
                                          ),
                                        ),
                                        backgroundColor: Color(0xFFAE69D5).withOpacity(0.1),
                                        side: BorderSide(
                                          color: Color(0xFFAE69D5).withOpacity(0.3),
                                          width: 1,
                                        ),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      )).toList(),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          // Level and ID Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level ${user.level}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFAE69D5),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFAE69D5).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'ID: ${user.id.substring(0, 8)}...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFAE69D5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatCard(user.maxHealth.toString(), 'HP', Colors.green),
                              _buildStatCard(user.maxMana.toString(), 'MP', Colors.blue),
                              _buildStatCard(user.badges.length.toString(), 'Badges', Colors.orange),
                              _buildStatCard('44', 'Friends', Colors.purple),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    _buildProgressIndicator(
                          'Experience',
                          user.currentXp,
                          user.maxXp,
                          Color(0xFFAE69D5),
                        ),
                    

                    SizedBox(height: 16),

                    // Action Buttons
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/inventory');
                              },
                              icon: Icon(Icons.backpack, size: 18),
                              label: Text('Inventory'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFAE69D5),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/friends');
                              },
                              icon: Icon(Icons.people, size: 18),
                              label: Text('Friends'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.grey[800],
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Achievements Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Achievements',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                '${user.badges.length} badges',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          if (_isLoadingAchievements)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  color: Color(0xFFAE69D5),
                                ),
                              ),
                            )
                          else if (user.badges.isEmpty)
                            Container(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.emoji_events,
                                    size: 48,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'No achievements yet!',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Complete quests and challenges to earn badges',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: user.badges.length,
                              itemBuilder: (context, index) {
                                final badgeId = user.badges[index];
                                final achievement = _achievementDetails[badgeId];
                                
                                return GestureDetector(
                                  onTap: () {
                                    if (achievement != null) {
                                      _showAchievementPopup(achievement);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _getAchievementIcon(achievement?['icon']),
                                          size: 32,
                                          color: Color(0xFFAE69D5),
                                        ),
                                        SizedBox(height: 8),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(
                                            achievement?['name'] ?? 'Loading...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700],
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Refresh Button
                    ElevatedButton.icon(
                      onPressed: () {
                        authService.refreshUserData();
                        _loadAchievementDetails();
                      },
                      icon: Icon(Icons.refresh, size: 18),
                      label: Text('Refresh Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFFAE69D5),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xFFAE69D5)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  IconData _getAchievementIcon(String? iconName) {
    if (iconName == null) return Icons.emoji_events;
    
    switch (iconName.toLowerCase()) {
      case 'trophy': return Icons.emoji_events;
      case 'star': return Icons.star;
      case 'medal': return Icons.military_tech;
      case 'badge': return Icons.workspace_premium;
      case 'crown': return Icons.king_bed;
      case 'shield': return Icons.security;
      case 'heart': return Icons.favorite;
      case 'fire': return Icons.local_fire_department;
      case 'bolt': return Icons.flash_on;
      default: return Icons.emoji_events;
    }
  }
}