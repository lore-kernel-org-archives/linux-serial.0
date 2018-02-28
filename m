From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 0/2] Update interrupt names
Date: Wed, 28 Feb 2018 10:51:16 +0000
Message-ID: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

This patchset updates existing stm32 usart driver by updating interrupt
initialization by name.

Bich Hemon (2):
  dt-bindings: serial: stm32: add wakeup option using note
  serial: stm32: update interrupt initialization

 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 drivers/tty/serial/stm32-usart.c                            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.9.1
