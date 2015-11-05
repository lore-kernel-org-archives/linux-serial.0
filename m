From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/11] tty: amba-pl011: add support for ZTE UART
 (EXPERIMENTAL)
Date: Thu, 5 Nov 2015 09:28:23 +0100
Message-ID: <CACRpkdbMUTUTJvCZXusMHDO4oqhXwo1DT8=h67ej9GSoDR5jvw@mail.gmail.com>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 3, 2015 at 3:51 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add (incomplete) support for the ZTE UART to the AMBA PL011 driver.
> This is similar to the ARM and ST variants, except it has a different
> register address layout, and requires 32-bit accesses to the registers.
> Use the newly introduced register tables and access size support to
> cope with these differences.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I applied the whole series, 1-11 and tested on Ux500 (ST Micro variant)
and on the ARM RealView PB11MPCore.

It works like a charm. I also like the looks of this transformation.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
