From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty: mxser: Fix build warning introduced by dfc7b837c7f9
 (Re: linux-next: build warning after merge of the tty.current tree)
Date: Wed, 22 May 2013 08:35:30 -0700
Message-ID: <20130522153530.GC10402@kroah.com>
References: <20130522133722.d52b827e455275dfdecf12dd@canb.auug.org.au>
 <alpine.LRH.2.00.1305221109110.10829@lnfm1.sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1305221109110.10829@lnfm1.sai.msu.ru>
Sender: linux-next-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 22, 2013 at 11:13:38AM +0400, Matwey V. Kornilov wrote:
> From: Matwey V. Kornilov <matwey@sai.msu.ru>
> 
> Fix build warning at mxser.c introduced by dfc7b837c7f9
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---

You forgot to add "reported-by:" :(

I'll go do it by hand...

thanks,

greg k-h
