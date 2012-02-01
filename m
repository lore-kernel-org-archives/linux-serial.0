From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] qcserial: log when an interface has too many
 altsettings
Date: Wed, 1 Feb 2012 14:02:32 -0800
Message-ID: <20120201220232.GB893@kroah.com>
References: <20120201210723.GB16802@google.com>
 <20120201211116.GA30758@kroah.com>
 <CADyrwZSN6xeibZzgaPCL7qZfpwrTLipkXwQUOTOMZGpg0uRhHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44793 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755045Ab2BAWGP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Feb 2012 17:06:15 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2F2D7212E0
	for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2012 17:06:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CADyrwZSN6xeibZzgaPCL7qZfpwrTLipkXwQUOTOMZGpg0uRhHw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ttuttle <ttuttle@chromium.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Feb 01, 2012 at 04:47:22PM -0500, ttuttle wrote:
> On Wed, Feb 1, 2012 at 16:11, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 else if (serial->interface->num_altsetti=
ng > 2) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&serial->dev->de=
v,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "too man=
y altsettings: %u",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial->=
interface->num_altsetting);
> >
> > Why would this happen? =A0And what does spitting out an error do ab=
out it?
> > What are we supposed to do with this information?
>=20
> This would happen if we found a device that was returning an
> unexpected USB configuration.  We've never actually seen this happen
> -- it was just there in case.  I can drop it if you think it's not
> worth the trouble.

As the code properly handles such an error, my point is, if a user sees
this new scary message, what are they supposed to do with it?

So yes, please drop it.

Are you going to resend this series based on the comments so far?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
