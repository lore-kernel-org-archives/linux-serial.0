Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D520B34
	for <linux-serial@vger.kernel.org>; Wed, 19 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798935; cv=none; b=ZrMbcUHQr2W4pWLElP0N6cE/uEHQmlV/voIMWIMZM1Z0w3o5j8LfmYQIMZPMqX3BmfE22v/DPGPp/GFhw2YgxKBsvy5NO6hIzyV/RdgxbbC7FXbp8GdWjzFf6qKkqnKBshi3hpebecx49/lRzrK5+3lovE+YHTgW0WXR1KaHO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798935; c=relaxed/simple;
	bh=fTvB1hEbxSBWiNyMp6BrQ//M2l+mBY4sasDhPslCkf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUs5E1Rb6ZV+ueC9NIqadvvemUgSdNma6YSuF9DLSizc4yP6Fx+fYFJMyzQBVogT8qT/GTRs29GDieuh/VStZhemvMQc0NFEUxIMqL6tEqtqnOAp0GDeMOxfwt6YUe7L4mxn28FMyQZme2/Q1/Eha1qvaB+utJsBhxU5rSFRyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ednkHCdY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ednkHCdY"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe785b234so65002871fa.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Jun 2024 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718798931; x=1719403731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z91cdWhBSDARxTwwrjzqK6+kNXQCrIMh1WvKGrr9e4=;
        b=ednkHCdYH2eogjaKBYnrL/+W+79v6Hjcwuz/LubW+GcFijJSXG9fiJNtANznqKgW5T
         nS1iYJ9M+r3EDKKUTpp9ZAOAKxzyQjaN8s6Lv3AIftep0am9NmDuCuhSLGEYauUv7s+4
         l1hygFEYZOE0U10+VjzNz3T3DVq1blr1TFwZ1PArDOPq1bufPy2fgoftG8b52WpyriIj
         WHTNccUfNrYsm5OTkDepBqFZzjdObsWudmdULUVirdOUQ/GdoaofL0vmsK+QYl7zcES1
         UqcnSlc2ePV4BRU7Ug+cJeB8HwJjEPTjcx+FsX4CSConWp424INyXJeEjHASLy1qwi02
         yN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798931; x=1719403731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z91cdWhBSDARxTwwrjzqK6+kNXQCrIMh1WvKGrr9e4=;
        b=JIobQnEhpHkBh/g4iO7K4G26Mn4j+kxo68ITLRwAeGU9zt1nYaxa/CvadbTHs/XfVS
         RI2H+q9Wx0NYmUhjJYpLi+hCuB7nlnIWoaHu/agjCukL/qrw3B6NsNHS/VkwpEtE6b0N
         aSnQl98JdRqq0mm0C1wQrZaBlUwkAw2GX1Grf4hdjvRp96jXDaJL/1jJvGt8Srfn/W48
         hFdOvNMNa/2JScLTLZoRODmH6wdf3tU9L8I2zi6ViXeh2zZAOSHGDIUlVxu+4lv3z4+m
         JO8H9g79Y5GNG3i2INH68ySXtOozH39fPLeOIcmSKx623cg9t1QwM9j/YupqdOxr/dqx
         H6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoxLLvM9U+Crue7n/gpOfwAmPJ4TYqZ+nivI24BQsir771ki5/zqSnPVuMejhempsPlZWQecR90UNFJraNWmmftbpYLw5TXJNTRjFp
X-Gm-Message-State: AOJu0YxqQZPWMRaylFzoAAeDsDAv3nliRnypT2/L+Fjl+vCFS2/rkH5g
	VCPIFnCE7RuoHSKvul687bj+9X2J8JORCPGJ2LxnpEiV3Koq5f82t0/GUSVfO5M=
X-Google-Smtp-Source: AGHT+IHxReTN0w2QaraX/PX9vfS48WsKjPuPHQ7NZwaQgMrkK4rxI3TUUAV/ivACQRkZaw1lT7yL1A==
X-Received: by 2002:a2e:a311:0:b0:2ec:27e6:39ba with SMTP id 38308e7fff4ca-2ec3cffce6emr16794281fa.53.1718798930960;
        Wed, 19 Jun 2024 05:08:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf49d7b1sm9480897a12.51.2024.06.19.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:08:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:08:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnLKSEzKBTXYvOMe@pathway.suse.cz>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
 <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
 <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>
 <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKGGoboxRMwkeWm@tlindgre-MOBL1>

On Wed 2024-06-19 10:17:46, Tony Lindgren wrote:
> On Wed, Jun 19, 2024 at 07:39:04AM +0300, Tony Lindgren wrote:
> > On Tue, Jun 18, 2024 at 03:51:44PM +0200, Petr Mladek wrote:
> > > It seems to try whether c->devname matches a number "X", or "ttySX".
> > > It even tries the sparc-specific transformations in
> > > serial_base_add_sparc_console()
> > > 
> > > But this is the original format which does _not_ include ":".
> > > It never will be stored in c->devname and will never match.
> > 
> > Good catch, this won't do anything now with console_setup()
> > checking for ":" for deferred consoles. So we should revert commit
> > a0f32e2dd998 ("serial: core: Handle serial console options").
> 
> Heh actually we can revert a lot more, basically leaving only
> the renamed serial_base_match_and_update_preferred_console().

I wonder if it would be cleaner to revert all patches adding
the feature and then add back just the minimalist solution.

Best Regards,
Petr
