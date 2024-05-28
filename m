Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149C3D0A9;
	Tue, 28 May 2024 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872752; cv=none; b=mgFGJX8RD1u9v7N0jOLXgEoTpcKMvcvw5BOx2kVoG6vSjBVTTUTChJ/X2O4A+eEX0CAi+zFXlUxczI03Lyz7aNyC8rltalN6kv4H6oA0/p+JNBMgruX+2rep//Apdg8enC2E1ThlUYDVdbvqQNWeyXteUrmI+TojZnnCcKSuyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872752; c=relaxed/simple;
	bh=Tovpx1FZiQz8QrAsCt+bRrI7/FqIEBYBeBt7CR34S4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTPl+RIdhDuqRwiiAwvjgUbGrhiDk9wy4nHkRhoiFSYB6d0IoPUKdRtJVR4xFxxX+0q5yLFOUoJIrb733lH6mYpl2H+Kj2XLJx7930GjlyqcIXY30TjQlxE68AYJlV36OBNoEmeVxyiNCl3nsfrJqQoeRXouPh1G3ciN0t+eQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0JSsi6S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0JSsi6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716872751; x=1748408751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tovpx1FZiQz8QrAsCt+bRrI7/FqIEBYBeBt7CR34S4s=;
  b=P0JSsi6SKENrWuzmMJTxMm4FnWkhc9zucbwuxnLNh/RhdwXJF71c3RH4
   MOGaqOLbYQV6eJZBF6B1ovKJcDESUKTXrpuuMQim2N3AQQQ8n4fHgJr0R
   XGVxRUFtOhDCAn6mtSd0Vlf/aUpR42J+yg4m8qpumUIVtUOcMb2IGn/PE
   IxS651/fWLJcNcfk2e/l1Vnu1dr3+ht1roCrW7hB5mkQmjCUCGVHv8ox/
   8ONjXsueWIjRaifBWK0sUSlWyh0YnjKt6KXnsyqYYxJAw43LilObAzroh
   G8/1H97jh7e5i2qeDrrOEBlYcPNY1tf6TKEP0/Vj47vv+9ouBdwV2gJzn
   g==;
X-CSE-ConnectionGUID: M6NfgT+nQUy0HmSSmmBj+g==
X-CSE-MsgGUID: +IMiLqP2Rp+NxaCUxv3KIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23754621"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="23754621"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 22:05:51 -0700
X-CSE-ConnectionGUID: RvDHCeTkQayOwMhelFDzFA==
X-CSE-MsgGUID: 56kAMEmLT5Gpex9PNJZSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39476804"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.244.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 22:05:44 -0700
Date: Tue, 28 May 2024 08:05:37 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
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
Message-ID: <ZlVmIcu2NQOXg9rx@tlindgre-MOBL1>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
 <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
 <ZlRqz2b0ZrtkxScL@tlindgre-MOBL1>
 <ZlSOc5mtbf4DdI8O@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlSOc5mtbf4DdI8O@pathway.suse.cz>

On Mon, May 27, 2024 at 03:45:55PM +0200, Petr Mladek wrote:
> On Mon 2024-05-27 14:13:19, Tony Lindgren wrote:
> > To me it seems we can fix this by keeping track of the console position
> > in the kernel command line. I'll send a fix for this to discuss.
> 
> Honestly, I would prefer some alternative solution of the whole
> problem. From my POV, the current patchset is a kind of a hack.
> 
>   1. It hides console=DEVNAME:X.Y options so that register_console()
>      does not know about them.

OK let's make register_console() aware of the DEVNAME:X.Y options.
I like what you're suggesting towards the end of your message for
this.

>   2. But wait, register_console() might then enable any random console
>      by default when there are not console= options. For this the 3rd patch
>      added @console_set_on_cmdline variable which would tell
>      register_console(): "Hey, I have hidden some user preferences.
>      I'll tell you about them when the right time comes."

That's to allow setting up a console when the driver is ready. So that 
we don't need to rely on the hardcoded device name deciphering at
console_setup() time. Maybe there's a better way to signal that though.

>   3. When port init matches the pattern, it adds the preferred console
>      so that the register_console() would know about it.
> 
>   4. But wait, the ordering of preferred consoles is important.
>      Which would require more hacks to preserve the ordering.

Preserving the ordering part is probably the smallest issue to deal with
here :) I agree we should try to make things simpler though and there
certainly are already lots of magic switches setting up the console.

>   5. Also serial_base_add_prefcon() adds the preferred console
>      with the generic name "ttyS" which is not specific
>      for the matched device. It just hopes that the very next
>      "register_console()" call will be the one related to
>      the matching device. Is this really guaranteed on SMP system?

Hmm not sure I get this issue though, when serial_base_add_prefcon() gets
called we know the device name. The "ttyS" parts are needed to avoid
relying on the hardcoded device name deciphering at console_setup() time.

If you're thinking about the serial8250_isa_init_ports() related calls,
the serial port mapping uses SERIAL_PORT_DFNS. And then a hardware
specific 8250 may take over at some point :)
 
> IMHO, the only solution would be to add a function which would
> return "ttySX" for the fiven device name.

Yes agreed, this will simplify things.

> Honestly, I do not know the hiearachy of the structures in detail.
> But the documentation in the 7th patch says:
> 
> +			The mapping of the serial ports to the tty instances
> +			can be viewed with:
> +
> +			$ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
> +			/sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
> 
> BTW: I get on my test system:
> 
> # ls -1 -d /sys/bus/serial-base/devices/*:*.*/tty/*
> /sys/bus/serial-base/devices/00:00:0.0/tty/ttyS0
> /sys/bus/serial-base/devices/serial8250:0.1/tty/ttyS1
> /sys/bus/serial-base/devices/serial8250:0.2/tty/ttyS2
> /sys/bus/serial-base/devices/serial8250:0.3/tty/ttyS3
> ...

OK

> It looks like it should be possible to provide a function which would
> return:
> 
>    "ttyS0" for "00:00:0.0"
>    "ttyS1" for "serial8250:0.1"
>    ...
> 
> 
> This function might then be used in "register_console()"
> to convert "console=DEVNAME:0.0" option to "ttyS" + "index".
> 
> The advantage would be that the relation between "DEVNAME:0.0"
> and "ttyS0" will be clear. And the code would see the same hiearachy
> as the user in /sys/bus/serial-base/devices/.

OK makes sense to me.

> Of course, I might be too naive. Maybe, the sysfs hieararchy is
> created too late. Maybe, it is not easy to go throught the
> hiearachy...
> 
> But still. I wonder if there is a straightforard way which would
> allow translation between "ttySX" and "DEVNAME:0.0" naming schemes.

We can do that on driver probe time no problem. The issues are mostly
related to setting up things early on.

Regards,

Tony
