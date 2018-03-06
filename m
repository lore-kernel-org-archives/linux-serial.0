From: <patrice.chotard@st.com>
Subject: [PATCH v2 0/3] Fix STi aliases property name
Date: Tue, 6 Mar 2018 09:07:27 +0100
Message-ID: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
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

_ Patch 2, remove useless stdout-path property

_ Patch 3, rework the tty driver st-asc accordingly, as aliases id is retrieved 
  using of_alias_get_id() with a defined string with is not lowercase only.

v2: Fix Rob Herring's remarks :
  	  _ use serialN instead of ttyasN aliases to not break ABI
	  _ remove useless stdout-path property
	  _ update st-asc driver with "serial" alias prefix

Patrice Chotard (2):
  ARM: dts: STi: Fix aliases property name for STi boards
  ARM: dts: STi: Remove useless stdout-path for STi boards
  tty: st-asc: Update tty alias

 arch/arm/boot/dts/stih407-b2120.dts | 5 ++---
 arch/arm/boot/dts/stih410-b2120.dts | 5 ++---
 arch/arm/boot/dts/stih410-b2260.dts | 5 ++---
 arch/arm/boot/dts/stih418-b2199.dts | 5 ++---
 drivers/tty/serial/st-asc.c         | 2 +-
 5 files changed, 9 insertions(+), 13 deletions(-)

-- 
1.9.1
