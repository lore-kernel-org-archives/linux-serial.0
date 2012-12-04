From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCHv3 3/5] serial: 8250_dw: Map IO memory
Date: Tue, 4 Dec 2012 17:02:58 +0000
Message-ID: <20121204170258.GA6641@page>
References: <20121204081713.GA8071@xps8300>
 <1354634512-19299-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354634512-19299-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Looks good to me!

On Tue, Dec 04, 2012 at 05:21:52PM +0200, Heikki Krogerus wrote:
> This needs to be done in order to later access the
> Designware specific registers.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
