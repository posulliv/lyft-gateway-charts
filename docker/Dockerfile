#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM registry.access.redhat.com/ubi8/ubi

ENV JAVA_HOME /usr/lib/jvm/zulu11
RUN \
    set -xeu && \
    yum -y -q install https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm && \
    yum -y -q install zulu11-jdk less && \
    yum -q clean all && \
    rm -rf /var/cache/yum && \
    groupadd gateway --gid 1000 && \
    useradd gateway --uid 1000 --gid 1000 && \
    mkdir -p /gateway/bin /gateway/logs && \
    chown -R "gateway:gateway" /gateway 

ARG GATEWAY_VERSION
COPY --chown=gateway:gateway gateway-ha-$GATEWAY_VERSION-jar-with-dependencies.jar /gateway/gateway-ha.jar
COPY --chown=gateway:gateway default-ha-config.yml /gateway/config.yml
COPY --chown=gateway:gateway bin/run-gateway /gateway/bin
COPY --chown=gateway:gateway bin/health-check /gateway/bin

EXPOSE 8080 8090 8091
USER gateway:gateway
ENV LANG en_US.UTF-8
CMD ["/gateway/bin/run-gateway"]
HEALTHCHECK --interval=10s --timeout=5s --start-period=10s \
  CMD /gateway/bin/health-check
