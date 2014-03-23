# https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+as+a+Unix+daemon
# Daemonize
echo "Starting jenkins"
touch /var/run/jenkins.pid
chown jenkins:jenkins /var/run/jenkins.pid
mkdir -p /var/log/jenkins
chown jenkins:jenkins /var/log/jenkins
su -s /bin/sh jenkins -c "
                cd /
                JENKINS_HOME=/home/jenkins/.jenkins exec setsid /usr/bin/java   \
                        -jar /home/jenkins/jenkins.war          \
                        $JENKINS_OPTS                                    \
                </dev/null >>/var/log/jenkins/console_log 2>&1 &
                echo \$! >/var/run/jenkins.pid
                disown \$!
                "
