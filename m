From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCHv2 0/5] serial: 8250: 8250_dw changes and dynamic
 capabilities
Date: Mon, 3 Dec 2012 15:43:54 +0000
Message-ID: <20121203154354.GB20140@page>
References: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Heikki,

On Mon, Dec 03, 2012 at 01:17:54PM +0200, Heikki Krogerus wrote:
> 
> Changes since v1:
> - rebased on top of Greg's tty-next
> 
> These are mainly small 8250_dw.c changes. The interesting patch is
> probable the first one that changes 8250.c so the drivers are able to
> deliver their UART's capabilities when they are registering ports.

Other than my comment on 3/5 it looks great.

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
