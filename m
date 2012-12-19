From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] synclink fix ldisc buffer argument
Date: Tue, 18 Dec 2012 20:09:07 -0800
Message-ID: <20121219040907.GA22719@kroah.com>
References: <50B8DDAC.8070901@microgate.com>
 <50B90D0D.9040401@microgate.com>
 <20121202151332.3b6a6504@pyramind.ukuu.org.uk>
 <F6B8A325-7DBF-4623-B16C-CDC5642EFD16@microgate.com>
 <20121202181057.097012c6@pyramind.ukuu.org.uk>
 <989CB961-79F8-479B-B16C-41358A60AC94@microgate.com>
 <50BC0C84.4060802@asianux.com>
 <50BCCD4C.8050209@microgate.com>
 <50BEAA0E.9000603@asianux.com>
 <50D12521.8010808@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50D12521.8010808@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 19, 2012 at 10:23:29AM +0800, Chen Gang wrote:
> Hello Paul Fulghum:
> 
> it seems you are very busy,
>   and can not get your reply for "checking length in function rx_get_buf".

You should always send patches, long emails like this about "potential"
issues are hard to handle, patches are best.

greg k-h
