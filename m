From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] tty: amba-pl011: add register lookup table
Date: Sat, 12 Dec 2015 22:03:25 -0800
Message-ID: <20151213060325.GA23244@kroah.com>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
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
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 03, 2015 at 02:51:18PM +0000, Russell King wrote:
> Add a register lookup table, which allows the register offsets to be
> adjusted on a per-port basis.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/tty/serial/amba-pl011.c | 33 ++++++++++++++++++++++++-
>  drivers/tty/serial/amba-pl011.h | 53 ++++++++++++++++++++++-------------------
>  2 files changed, 60 insertions(+), 26 deletions(-)

I'm guessing I should stop here in the series, so I haven't applied
this, or any patch after this to my tree.  Please resend what you have
left over as I think you have updates.

thanks,

greg k-h
