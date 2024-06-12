Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245417F517
	for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203696; cv=none; b=osSf8gUHaxbI8FAB4AjrUoraidnIRJXLthSX1CghZCEknRcvNQY9jVUvw+LcwBUSGf3Hctjx6S9ajyJXgIUKSyT4tDx8DzX44yW7V+amq8VXcnWUc/KviyNBiwCIBfADJuB3VHSVpniXrjAG8Uk5rArpk1z735en2cb9NJJYsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203696; c=relaxed/simple;
	bh=gTvUfeVcV0WBX/VSstMj3P4uHESmQaeTlXAV82NwTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOts+Cew4+syJAX4Qkiz3JkvpJYiMtRqiz8bdijzv736h1PdofkNPzPeuP4KIMwslGTn9yca4pAB3s7X30ICbgn0mx7hcApqAbaRRwnMdJinJu0M+qdvMkjwaPeg6caG9f00hQjO0WauGR88FZOSTTHMiBzBtV4VVhKPvbTc+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cqY9wgKi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cqY9wgKi"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so179760966b.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2024 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718203693; x=1718808493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8IWtwzoqSJWM3Lgz12Iah6lW8otD2wfGj7uZTal1qAE=;
        b=cqY9wgKiuy/ci4WOO9TbMUPtNwcwMQ34cJH3IY9Frn0/1QtkzeFZ0/Enb4mBdslaKX
         7539l0Iolf4DarmHzWhJyCLey7SdTSsnjNAlP7NUKW64XYgijMBoVK6rHGxb699Zg5Lj
         3+kil24oBa/8I8eoXdvKPdSph69/MY7lBrhshKAdE9RPKp1dTev6JFaBJN4AbiE2dket
         TcYZgyMAQ6387fnjs/iO331jpXQLwmhpFXS2PlCGusNu7FJAtk0EX9o2CHW9Lw3CTDGV
         U5T0vr2xB/fzegSBsrVr9uKjj2Zdps6cmun3TGsy8O19GHR2Mz92CSP6g+VWUJZ4bFAX
         LtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203693; x=1718808493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IWtwzoqSJWM3Lgz12Iah6lW8otD2wfGj7uZTal1qAE=;
        b=qvLi69umfMnYl8HOBWi4Vuc+MJKTuMBZhfoCrPHKVbsz8VdoFkQl0r3IXslYozR+Xf
         CA6DRszvFcNOpmdM9fmNtWJTfV+fIcXFj4y/Ex+YgsZoleXNXjwj+23xI+oyeA1IuolQ
         ENWuI1If7lYBS3X669dlk+x5RgSW3v3BR8WNsaiYeYVRNKFpXh3aRT+jC70jU34F3D4Q
         5VQC1M488DDzO4vfyraxmzlW6lO10m3Q+6bNL/zBqT1JixED8LYolZDOqE6afuU+b/ev
         IrY4jGbcQEiDQReXIiRBgCsD0QnfJimpJKjAcPNLygpb5dHZUoRev7M5xQd5/u8xocXy
         P/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx0c5FzpgVCUrIP97j4qrRZd5dqFyUgrRgr5F2Z5qPzGC8AFKqnd+JHGhTMxHAOn1REBPd1WB63N5HlsQq5eitpQZlM2VS7mpvLLo1
X-Gm-Message-State: AOJu0YyNGj+pd8fKN55cqolo/3KOr7V3uAONcxLlovotnh0RwpKEeY4P
	aOpiT9wlFKIV58lSKCm+X1NL/ybBPWiHEAEOb7biVP8J9YeyzgvENs5FrGP1ETk=
X-Google-Smtp-Source: AGHT+IFe/XnrBiMyULWYXvobbO+KULp/ZOLbfPDdM4O64ls/uoXWS6C0Worus7xXfYnO3Uc+wuChjQ==
X-Received: by 2002:a17:906:ce44:b0:a6f:51b3:cbad with SMTP id a640c23a62f3a-a6f51b3cc99mr5567166b.25.1718203692687;
        Wed, 12 Jun 2024 07:48:12 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f19171cd0sm453652766b.61.2024.06.12.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:48:12 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:48:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Track command line console positions to fix
 console order
Message-ID: <Zmm1KpOKkigPRyrG@pathway.suse.cz>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
 <ZmgIB2lQaW9oqn3O@pathway.suse.cz>
 <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>

On Tue 2024-06-11 12:56:54, Tony Lindgren wrote:
> On Tue, Jun 11, 2024 at 10:17:11AM +0200, Petr Mladek wrote:
> > On Thu 2024-06-06 14:41:46, Tony Lindgren wrote:
> > > Recent changes to allow using DEVNAME:0.0 style console names caused a
> > > regression to the kernel command line handling for the console options.
> > 
> > Sigh, I have missed that it has already ended in the mainline via
> > the tty tree :-/
> > 
> > Honestly, I would prefer to revert it and implement it a clean way.
> > I see a lot of existing and possible problems:
> 
> Naturally no objection from me for reverting if there are issues that are
> unfixable from the printk point of view. I'll update the fix along the
> lines you're suggesting below though, let's see if that's enough for the
> -rc cycle.

OK, let's see how the updated fix looks like.

> > 1. Where and how is DEVNAME:0.0 defined?
> > 
> >    The only documentation seems to be in
> >    Documentation/admin-guide/kernel-parameters.txt for the console=
> >    parameter:
> > 
> > <paste>
> >                <DEVNAME>:<n>.<n>[,options]
> >                         Use the specified serial port on the serial core bus.
> >                         The addressing uses DEVNAME of the physical serial port
> >                         device, followed by the serial core controller instance,
> >                         and the serial port instance. The options are the same
> >                         as documented for the ttyS addressing above.
> > 
> >                         The mapping of the serial ports to the tty instances
> >                         can be viewed with:
> > 
> >                         $ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
> >                         /sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
> > 
> >                         In the above example, the console can be addressed with
> >                         console=00:04:0.0. Note that a console addressed this
> >                         way will only get added when the related device driver
> >                         is ready. The use of an earlycon parameter in addition to
> >                         the console may be desired for console output early on.
> > </paste>
> > 
> >    This seems to be a brand new bus.
> > 
> >    Is it stable?
> >    Is it documented in Documentation/ABI/stable/?
> 
> I think the DEVNAME originates from udev to be used for various rules. Yes
> it should be documented somewhere though. I'd say it's stable as it's been
> in use for years :)
> 
> >    It seems that the feature will cover "only" serial consoles.
> >    But DEVNAME is a generic name. It might make more sense to
> >    call it "SERIAL_BASE_DEVNAME" or "SERIAL_DEVNAME" or "SBASE_DEVNAME" or so.
> > 
> >    Anyway, console= is an interface with the user space. We will need to
> >    maintain the backward compatibility "forever".
> > 
> >       => we should think twice about the interface !!!
> 
> I think we want to keep it generic with DEVNAME, I don't see why we'd want
> make it serial console specific, at least in the code. For the documentation,
> I think the kernel parameters example  is clear on the serial port usage?

OK, let's keep the DEVNAME in both the code and documentation,

> > 3. The delimiter between "DEVNAME" and X.Y numbers is ":".
> >    But ":" is also part of the sample DEVNAME "00:00"
> > 
> >    Is it a good idea?
> > 
> >    Is the current naming scheme a well known historic one
> >    or something invented for the new bus?
> 
> PCI and USB use a ":" already for the device naming. Also a "-" can be used
> by the device names, many platform devices do that. I don't think we can
> pick any better limiter here, at least out of the ":", "-" and "." options.

OK, it seems that ':' is the best choice.

And thanks for explaining the other details. Everything makes more sense now.

Best Regards,
Petr
