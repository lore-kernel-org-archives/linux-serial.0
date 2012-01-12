From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: mxs-auart serial driver DMA support?
Date: Thu, 12 Jan 2012 08:33:20 +0200
Message-ID: <4F0E7EB0.2060906@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Any plans to add DMA support for mxs-auart serial driver? I noticed it 
is impossible to archive full 3.25 Mbs speed with current one.

There is DMA supported driver on freescale's git tree:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=drivers/serial/mxs-auart.c;hb=imx_2.6.35_11.09.01

As I understood porting DMA support from freescale's driver is not 
trivial because MXS DMA implementation has been changed to mainline version.

Regards,
Lauri Hintsala
