From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Fri, 10 May 2013 07:08:21 -0700
Message-ID: <20130510140821.GA4099@kroah.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de>
 <20130508153459.GA17186@kroah.com>
 <A3BF01DB4A606149A4C20C4C4C808F6C3189F9A245@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41192 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3EJOIM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 May 2013 10:08:12 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so2954965pab.18
        for <linux-serial@vger.kernel.org>; Fri, 10 May 2013 07:08:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A3BF01DB4A606149A4C20C4C4C808F6C3189F9A245@SAFEX1MAIL1.st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen GALLIMORE <stephen.gallimore@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Stuart MENEFY <stuart.menefy@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, May 10, 2013 at 03:50:16PM +0200, Stephen GALLIMORE wrote:
> Greg, having looked at this we have concluded that we should just go
> dynamic, as others have mentioned with udev on a full system or
> devtmpfs on a minimal initramfs system there is no reason to use a
> static major/minor. However the view here is that we would prefer to
> keep the unique name, as for example the lantiq driver which is also
> dynamic does, for the reason previously mentioned regarding PCIe
> cards.

Why do you want your own name?

> Is that acceptable?

I would prefer not to use a new serial port name, as this is only going
to make it harder for me to delete that name in the next year :)

Sorry,

greg k-h
