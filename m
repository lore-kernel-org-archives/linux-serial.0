From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement
 register diverson for ZTE UART
Date: Tue, 3 Nov 2015 14:30:20 +0000
Message-ID: <5638C4FC.5080407@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
 <20151103142343.GX8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103142343.GX8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 03/11/15 14:23, Russell King - ARM Linux wrote:
> On Mon, Nov 02, 2015 at 12:24:02PM +0000, Andre Przywara wrote:
>> +static struct vendor_data vendor_zte = {
> 
> This is unreferenced.  What's the detection mechanism for the ZTE UART?

Guess why I didn't include this ;-)

If I get [1] correctly, then it's a "zte,zx296702-uart" compatible
string for a starter (but no AMBA IDs, if I am not mistaken). I'd let
them fill in other ways of detection like ACPI.

Cheers,
Andre.

[1] http://marc.info/?l=linux-serial&m=143832902328904&w=2
