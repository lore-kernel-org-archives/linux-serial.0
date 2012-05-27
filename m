From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
Date: Sun, 27 May 2012 02:32:57 +0000
Message-ID: <201205270232.58253.arnd@arndb.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338048678-23991-1-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roland Stigge <stigge@antcom.de>
Cc: srinivas.bakki@nxp.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Saturday 26 May 2012, Roland Stigge wrote:
> Hi,
> 
> this is how the modified FIFO is handled in the repositories at
> git.lpclinux.com. Is there a better way for doing this (without ifdef)?  Looks
> like registering additional types (like PORT_16550A) isn't encouraged.  Maybe
> extending of_serial.c? The latter currently doesn't handle .fifosize and
> .tx_loadsz, though.
> 
> Any suggestions appreciated.

We occasionally add new types, and I think that would be ok here too, if it's
actually a new type. It definitely doesn't look like a 16550.

I wonder if it's in fact a PORT_16654, or if we can at least pretend it's one.
	
	Arnd
