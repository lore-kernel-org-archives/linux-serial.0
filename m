From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] pinctrl: zynq: fix two bugs of zynq pinmux function
Date: Wed, 20 May 2015 17:38:32 +0900
Message-ID: <1432111114-21163-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org




Masahiro Yamada (2):
  pinctrl: zynq: fix DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
  pinctrl: zynq: fix offset address for {SD0,SD1}_WP_CD_SEL

 drivers/pinctrl/pinctrl-zynq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
1.9.1
