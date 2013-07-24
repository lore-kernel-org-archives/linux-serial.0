From: Richard Zhao <rizhao@nvidia.com>
Subject: [PATCH 0/9] ARM: tegra: move to generic DMA DT binding
Date: Wed, 24 Jul 2013 12:09:53 +0800
Message-ID: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org
Cc: dev@lynxeye.de, swarren@wwwdotorg.org, vinod.koul@intel.com, gregkh@linuxfoundation.org, lgirdwood@gmail.com, rob.herring@calxeda.com, broonie@kernel.org, ldewangan@nvidia.com, rob@landley.net, djbw@fb.com, grant.likely@linaro.org, rizhao@nvidia.com, linuxzsc@gmail.com
List-Id: linux-serial@vger.kernel.org

The patch series aim to move apbdma to generic DT binding.

Changes:
- It add dmas/dma-names properties while leave
  nvidia,dma-request-selector to be compatible.
- update apbdma driver and dma client drivers
- ASoC tegra adds a new struct to pass device and dma-name.
- at last, remove legacy nvidia,dma-request-selector

Richard Zhao (9):
  ARM: dts: add generic DMA DT binding for tegra apbdma
  dma: tegra20-apbdma: move to generic device tree bindings
  spi: tegra114: move to generic dma DT binding
  spi: tegra20-slink: move to generic dma DT binding
  spi: tegra20-sflash: move to generic dma DT binding
  serial: tegra: move to generic dma DT binding
  ASoC: tegra: move to generic DMA DT binding
  ARM: dts: tegra: remove legacy nvidia,dma-request-selector properties
  dma: tegra20-apbdma: remove legacy nvidia,dma-request-selector support

 .../devicetree/bindings/dma/tegra20-apbdma.txt     |  1 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  8 ++--
 .../bindings/sound/nvidia,tegra20-ac97.txt         |  8 ++--
 .../bindings/sound/nvidia,tegra20-i2s.txt          |  8 ++--
 .../bindings/sound/nvidia,tegra30-ahub.txt         | 12 +++---
 .../bindings/spi/nvidia,tegra114-spi.txt           | 10 +++--
 .../bindings/spi/nvidia,tegra20-sflash.txt         | 10 +++--
 .../bindings/spi/nvidia,tegra20-slink.txt          | 10 +++--
 arch/arm/boot/dts/tegra114.dtsi                    | 41 +++++++++++++-------
 arch/arm/boot/dts/tegra20.dtsi                     | 40 +++++++++++++-------
 arch/arm/boot/dts/tegra30.dtsi                     | 37 ++++++++++++------
 drivers/dma/tegra20-apb-dma.c                      | 38 ++++++++++++++++++-
 drivers/spi/spi-tegra114.c                         | 16 +++-----
 drivers/spi/spi-tegra20-slink.c                    | 16 +++-----
 drivers/tty/serial/serial-tegra.c                  | 16 +-------
 sound/soc/tegra/tegra20_ac97.c                     | 17 +++------
 sound/soc/tegra/tegra20_ac97.h                     |  2 +
 sound/soc/tegra/tegra20_i2s.c                      | 26 ++++---------
 sound/soc/tegra/tegra20_i2s.h                      |  2 +
 sound/soc/tegra/tegra30_ahub.c                     | 25 +++++-------
 sound/soc/tegra/tegra30_ahub.h                     | 11 +++---
 sound/soc/tegra/tegra30_i2s.c                      | 44 +++++++++++++++-------
 sound/soc/tegra/tegra30_i2s.h                      |  2 +
 sound/soc/tegra/tegra_pcm.c                        | 14 +++++++
 sound/soc/tegra/tegra_pcm.h                        | 13 +++++++
 25 files changed, 260 insertions(+), 167 deletions(-)

-- 
1.8.1.5
