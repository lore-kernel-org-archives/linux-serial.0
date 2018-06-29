From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Fri, 29 Jun 2018 10:43:30 -0600
Message-ID: <20180629164330.GL27027@cisco.cisco.com>
References: <20180628120542.GA4065@kroah.com>
 <20180629102446.11189-1-tycho@tycho.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180629102446.11189-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 29, 2018 at 04:24:46AM -0600, Tycho Andersen wrote:
> v2: switch to locking uport->lock on allocation/deallocation instead of
>     locking the per-port mutex in uart_put_char. Note that since
>     uport->lock is a spin lock, we have to switch the allocation to
>     GFP_ATOMIC.

Serge pointed out off-list that we may want to do the allocation
before the lock so that it's more likely to be successful. I'm happy
to send that change to this if it's what we want to do, I don't have a
strong preference.

Tycho
