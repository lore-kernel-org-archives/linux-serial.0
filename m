From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH V6] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 17:26:02 -0700
Message-ID: <20110430002602.GA1818@kroah.com>
References: <64601bfb-0904-4741-8fc8-075a262c988c@VA3EHSMHS024.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64601bfb-0904-4741-8fc8-075a262c988c@VA3EHSMHS024.ehs.local>
Sender: linux-kernel-owner@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, michal.simek@petalogix.com, joe@perches.com, grant.likely@secretlab.ca
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 29, 2011 at 06:13:07PM -0600, John Linn wrote:
> The Xilinx PS Uart is used on the new ARM based SoC. This
> UART is not compatible with others such that a seperate
> driver is required.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
> 
> V6 
> 
> Removed legal footer issues. My apologies Greg.

Nope, it's still there:

> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 

{double sigh}
