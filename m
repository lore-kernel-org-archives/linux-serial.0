Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535351E4AE
	for <linux-serial@vger.kernel.org>; Mon, 27 May 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817561; cv=none; b=JihF3Q4cEOa+cJDQMFLjvVklYa3UgszBPFP0cFYpsC2ZI1A+fEGSoBEzyWdIIZUoDsgVTOKQSj44tg62rOpB4nRVnBrX4JzlI/vp7GkpXWpFHz4tKp68s0QJZvz0N5DPUYtKZptq44RNfuNsZlHR7mCO34GTOdvTwQTROD2E0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817561; c=relaxed/simple;
	bh=Nx5foiiBazlvj8RTv+u3oP8WZFmgrmmxvx/kNpkqBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Tp+zpjNJyNxJ2susS8gMiJWJsg93GnUN6ZKUIdnLjdHG++aqU5zc7Kwf5pJMQeefCkALiOVpwlzAP6hN391mB4uj5D3I+pccj+uahhlb4AbbIO2eCpx1elo69QKWxxl13ZWBy/aNRxNZexmvzYSbG2KIhlBIKCYka+szwYBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dh3q594G; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dh3q594G"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso3022074a12.3
        for <linux-serial@vger.kernel.org>; Mon, 27 May 2024 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716817558; x=1717422358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnjb6Mi3KXzRc2VXrdqyF2tyiKaAQ8iuOBdqH9Khxzw=;
        b=dh3q594GS8C3uXWyTuQMAt1l5khR1D0do1T/jKPGV0LnnfYtC6R8wBgobzPp0vWOed
         xJj1NPyeJ4obihELNM4z86OD9cmbK5hMct/CIpcaVyutKKYvXSR31qESzCYDeTOfL9Sm
         9fm0aQjHtnWj5oCw94MSKMs9v42kiJbIx+89/qqKx33YXuxkkVe0/k6Bjhru+la4g9XF
         CjMNMGyyPjffHHG+ySFhp6u/XXrV/NPer5F812+ZJqdb8Hp/xM6AI38ozuE4Ui7VlMZ5
         y3ATyVQPOhovSByt61yaVFi6AM88OMIS1LdFcL4rBSh9qWtX+7yT7bUwgS3TKUSGXz4g
         dEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817558; x=1717422358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnjb6Mi3KXzRc2VXrdqyF2tyiKaAQ8iuOBdqH9Khxzw=;
        b=eHlDNJJU0oKzYdECugnIxHi+0UNQnQ0mLCnmxDWHeYIOOLQTJibsgm/wtXV4mjprZ3
         M07FsjebMBR7QekroxCF8jviyxU6ykhFWDfcNZ+sIiYfJLb6LN/p6IatTKBMMDLiNBVD
         OnuYWbSiZ852tw79QZo0w6j5WZ015z8hjwx5ap/YmVxHXMnO/a7vm0Ouccq+7kn6c+k/
         QDdD75h5BqaEPfWCiW8nHn/ff3LvviG4Hm1ZOiYidVfnKuihd8zkSYkLaeIlqUMgzetF
         3jgaUS5PZVWAVpkA2pyxug/WbuHZ1N8eKdL6Im37kRyfkKXENa8VQkj6iwaZuHB+S2iL
         80Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUJQBW+VChBwbaHqBHKvVsI9nrO3gAhxfFFsTYiSB7QFyNmBuYAOMH9Y4VY3teHE/BnAyx7zJrI8a/5ypUuC1ir4+PFk6RQSiJMcgfT
X-Gm-Message-State: AOJu0YzlrDBRCIflMrEbdkiZYwexrN+o33bUK0tL6wlsNJz8KS0mkEmC
	f7X/G9vrNJuzqM8+1BT6oYsdFcpwGS6m0dytIR5W4lOwfRO+YGq7xjITvaAJgH+ypTiZP/kNIq4
	h
X-Google-Smtp-Source: AGHT+IGdJpB2qTzwGXzLhMxon+AJ6tq5ZCNAau0hwx6X7VTFF/HWjMsGQ/gVTXasBRtVDHE1rHySpA==
X-Received: by 2002:a50:999b:0:b0:579:c28f:6d10 with SMTP id 4fb4d7f45d1cf-579c28f6f3dmr3030589a12.24.1716817557564;
        Mon, 27 May 2024 06:45:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d1f94e72sm1661623a12.24.2024.05.27.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:45:57 -0700 (PDT)
Date: Mon, 27 May 2024 15:45:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/7] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZlSOc5mtbf4DdI8O@pathway.suse.cz>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
 <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
 <ZlRqz2b0ZrtkxScL@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlRqz2b0ZrtkxScL@tlindgre-MOBL1>

On Mon 2024-05-27 14:13:19, Tony Lindgren wrote:
> Hi,
> 
> On Fri, May 24, 2024 at 06:06:21PM +0200, Petr Mladek wrote:
> > I have finally found time to looks at this again.
> 
> Great good to hear.
> 
> > First, about breaking the preferred console:
> > 
> > The patchset still causes the regression with /dev/console association
> > as already reported for v3, see
> > https://lore.kernel.org/r/ZWnvc6-LnXdjOQLY@alley
> 
> Thanks and sorry for missing this issue. I thought I had this issue
> already handled, but looking at what I tested with earlier, looks like
> I had the console options the wrong way around.
>  
> > I used the following kernel command line:
> > 
> >    earlycon=uart8250,io,0x3f8,115200 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=1M
> > 
> > The patchset caused that /dev/console became associated with
> > ttyS0 instead of tty0, see the "C" flag:
> > 
> > 	original # cat /proc/consoles
> > 	tty0                 -WU (EC    )    4:1
> > 	ttyS0                -W- (E  p a)    4:64
> > 
> >    vs.
> > 
> > 	patched # cat /proc/consoles
> > 	ttyS0                -W- (EC p a)    4:64
> > 	tty0                 -WU (E     )    4:1
> 
> OK
> 
> > I have added some debugging messages which nicely show the reason.
> > In the original code, __add_preferred_console() is called twice
> > when processing the command line:
> > 
> > [    0.099312] __add_preferred_console[0]: ttyS, 0 (preferrred_console == 0)
> > [    0.099982] __add_preferred_console[1]: tty, 0 (preferrred_console == 1)
> 
> OK thanks for tracking down where things go wrong.
> 
> > The code thinks that "ttyS0" has been mentioned on the command line
> > once again. And preferred_console is _wrongly_ set back to '0'.
> > 
> > My view:
> > 
> > The delayed __add_preferred_console() is a way to hell.
> > 
> > The preferences are defined by the ordering on the command line.
> > All entries have to be added when the command line options are
> > being proceed to keep the order.
> 
> To me it seems we can fix this by keeping track of the console position
> in the kernel command line. I'll send a fix for this to discuss.

Honestly, I would prefer some alternative solution of the whole
problem. From my POV, the current patchset is a kind of a hack.

  1. It hides console=DEVNAME:X.Y options so that register_console()
     does not know about them.

  2. But wait, register_console() might then enable any random console
     by default when there are not console= options. For this the 3rd patch
     added @console_set_on_cmdline variable which would tell
     register_console(): "Hey, I have hidden some user preferences.
     I'll tell you about them when the right time comes."

  3. When port init matches the pattern, it adds the preferred console
     so that the register_console() would know about it.

  4. But wait, the ordering of preferred consoles is important.
     Which would require more hacks to preserve the ordering.

  5. Also serial_base_add_prefcon() adds the preferred console
     with the generic name "ttyS" which is not specific
     for the matched device. It just hopes that the very next
     "register_console()" call will be the one related to
     the matching device. Is this really guaranteed on SMP system?


IMHO, the only solution would be to add a function which would
return "ttySX" for the fiven device name.

Honestly, I do not know the hiearachy of the structures in detail.
But the documentation in the 7th patch says:

+			The mapping of the serial ports to the tty instances
+			can be viewed with:
+
+			$ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
+			/sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0

BTW: I get on my test system:

# ls -1 -d /sys/bus/serial-base/devices/*:*.*/tty/*
/sys/bus/serial-base/devices/00:00:0.0/tty/ttyS0
/sys/bus/serial-base/devices/serial8250:0.1/tty/ttyS1
/sys/bus/serial-base/devices/serial8250:0.2/tty/ttyS2
/sys/bus/serial-base/devices/serial8250:0.3/tty/ttyS3
...

It looks like it should be possible to provide a function which would
return:

   "ttyS0" for "00:00:0.0"
   "ttyS1" for "serial8250:0.1"
   ...


This function might then be used in "register_console()"
to convert "console=DEVNAME:0.0" option to "ttyS" + "index".

The advantage would be that the relation between "DEVNAME:0.0"
and "ttyS0" will be clear. And the code would see the same hiearachy
as the user in /sys/bus/serial-base/devices/.

Of course, I might be too naive. Maybe, the sysfs hieararchy is
created too late. Maybe, it is not easy to go throught the
hiearachy...

But still. I wonder if there is a straightforard way which would
allow translation between "ttySX" and "DEVNAME:0.0" naming schemes.

Best Regards,
Petr
