From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement
 register diverson for ZTE UART
Date: Tue, 3 Nov 2015 14:23:43 +0000
Message-ID: <20151103142343.GX8644@n2100.arm.linux.org.uk>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 02, 2015 at 12:24:02PM +0000, Andre Przywara wrote:
> +static struct vendor_data vendor_zte = {

This is unreferenced.  What's the detection mechanism for the ZTE UART?
This is the last piece of information I need to finish my set of patches.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
