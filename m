From: <patrice.chotard@st.com>
Subject: [PATCH v3 0/3] Fix STi aliases property name
Date: Wed, 7 Mar 2018 09:49:54 +0100
Message-ID: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, when compiling dtb with W=1 option,
the following warnings are triggered :
    
arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

_ Patch 1, convert the aliases property name in lowercase in 
  all STi board dts files.

_ Patch 2, remove "console=serialN" from bootargs property

_ Patch 3, rework the tty driver st-asc accordingly, as aliases id is retrieved 
  using of_alias_get_id() with a defined string with is not lowercase only.

v3: Fix Rob Herring's remarks :
      _ remove "console=serialN,115200" from bootargs and use prefered stdout-path property
      _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice

v2: Fix Rob Herring's remarks :
      _ use serialN instead of ttyasN aliases to not break ABI
      _ remove useless stdout-path property
      _ update st-asc driver with "serial" alias prefix

Patrice Chotard (3):
  ARM: dts: STi: Fix aliases property name for STi boards
  ARM: dts: STi: Remove console=serialN from bootargs for STi boards
  tty: st-asc: Update tty alias

 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 drivers/tty/serial/st-asc.c         | 4 +++-
 5 files changed, 11 insertions(+), 9 deletions(-)

-- 
1.9.1
