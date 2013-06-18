From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Tue, 18 Jun 2013 12:26:05 -0700
Message-ID: <20130618192605.GA21038@kroah.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 18, 2013 at 12:12:53PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o OCTEON must have 64-bit wide register accesses, so we have OCTEON
>   specific register accessors.
> 
> o No UCV register, so we hard code some properties.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
