Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9F20C00C
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443817; cv=none; b=E+tr/6xjULE2XOftpKbhifT7CB1cmakckZvuY/IpVO1Sx6wwVWgc4mIc+IfOwmJVbD4alxtxG6a0FCwzEfeuu/nbTHCG7uN71Hu0STP5s7r8xkMV2C632xGZnwl24aSzOYo7kYMaFkuJHgBDU/IiH1+r8Dkpk/hj+TMaQDbinok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443817; c=relaxed/simple;
	bh=870BLlmnjaQzbvDuOSI2WTedhVSR09w55CsyFy8Gvoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaIepRYNLJZeB8GBnVDDohxsymEGsCEmDcw77AZ8zu22/w8kSgZGJTf5MMD5uQ4O16/W3L/I9ZVcLSyqGiaV0aXRPUwqW//GoBWkyjGNEsMPN9sNdgbiE6xSE3+bDINjKjdQSbIGd1zIfUCb3PPrPIGMXmO9mASeDihNweOX2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcwY5eDG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcwY5eDG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so22839285e9.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773443814; x=1774048614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faLV0VjvivhJKHu5qLQCO8yMtnUSYFQyyAoRC1+Ysj8=;
        b=QcwY5eDGJqXLwcJOvZKc6LZ5Yh3glH1xqjHtbcl309c9ww1blAFw4VCYrK40Su+Yz2
         Mz+Hyiz8XSfsP7J5c1EFRKPOhw2TiDfV0m9BUIw5xMBQyc7xx1rK+u5yPhz+deYNqs6F
         omiPPfaTg6ja/2Q9RsyVUC/F61V6wgXjJkBHp4zLsTzUCzzYw8R4Ep7+CXVLb2RAj0aS
         tTF1FC3TJRne+J7IFuFe27l8pvSJ3zOxKvcajy/bWmo/88UbFTkCSo+CV+ugPSvKv2ey
         lTzDE/0u2Q07XB9/ZL01KPyyiQ9el3Rs23IfF5g9V3bfKC3C5MuCbODn1g9BsQsPirXR
         1fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773443814; x=1774048614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faLV0VjvivhJKHu5qLQCO8yMtnUSYFQyyAoRC1+Ysj8=;
        b=AfgiBRUQsARIcUnPi507eIBe+fveFN2tXfMc9N2oCQccSQlwpRJqeX68FnuxiwgVxd
         UgXLqVW1mtnIhW18rxTz6PfDNduphta5kNKPPSpwlhH7BLbX0uq8jBRxoHbFnBOVySyo
         166pOoxTWNTJZeRFU8djgxVh+QtFP5oyeB/g+uAVWKVS9U2/+vmOkeSHugxvl1vsOPAs
         u8Z8ksNTxSLUSt0XZcR+2f3uJTxZGC98PyMzWhP2RSRX3+UOvIU0YAQyI5qd7a5dk3L8
         R9oK6RO4am8V0KGaLpkjh71yv1pHPgmepGM+DeN2E1dWPHw2kjpcwrvYQxWqnXFj3tYo
         2ZCA==
X-Forwarded-Encrypted: i=1; AJvYcCX2pIhfZnoTfcDKFiDXtD4GAFXIB5no5/a3vJe6e2hje04uDdxCjZIOODiKhluTzVdPFpe9RwXFXzeEeU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfI2AddYCLNVFlN2g/0tC21JFdi8jYBQ/8G3DR64J2DVo+jEzR
	lKBXbsndPMD5mbWFnjtstbj0shYFgxatf7p312mwb+iKG/BOE/QZOc3U
X-Gm-Gg: ATEYQzzuT18D/XeIuEBdYIO2Bf3fhXq+w3/SsPBRO1cOXt+GngdObSz1ZOnLbmbhLfg
	aT6NMxqrvjGl4j8em5JwFiH5J+lbh61k3Mjs2U3buMIm4JhopfIChuTUJrVL9LYM0j+1g+irUvD
	sECjXBtMLmSs4qp+pClBR9p7tHA0YdwYCpJAhZR5c2LLJ71AIZnsQckiZCo5lJZixFxdQR/T6tH
	75ppG2P4IFzpq1E6q7lwSKN12aoYJtWNirdmj2i6nbPZOEAdTWXXcj93MWeBSNNmSms/TSaUq9k
	s56EuN2Xw3DoBIcNyLNTfHlQgTNlCKgURdFWZmr5X7P3dZyiAAQCyBf1mwzWOUVpcVYNA1yP2AN
	Cj8Fr/JYhdKAvN+FZhqWIZH/FEI/HbniGLqDBobn2aZQaOCvgUDDVBg4OO5GyqX8Z5UQAgegbFz
	i2R6hetKJTp9JnmOQXjAJl1bn3PeVNZJgg+VUNB93cuBzAgXJNynqqSu62zw==
X-Received: by 2002:a05:600c:a46:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-485566d6ff2mr87992695e9.11.1773443813972;
        Fri, 13 Mar 2026 16:16:53 -0700 (PDT)
Received: from osama ([156.223.222.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273e8sm22237484f8f.33.2026.03.13.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 16:16:52 -0700 (PDT)
Date: Sat, 14 Mar 2026 00:16:49 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_tty: fix KCSAN data-race in n_tty_flush_buffer /
 n_tty_lookahead_flow_ctrl
Message-ID: <abSa4VAXaMBEjVjD@osama>
References: <20260211210838.45127-1-osama.abdelkader@gmail.com>
 <2026031211-scared-riches-6a52@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031211-scared-riches-6a52@gregkh>

On Thu, Mar 12, 2026 at 03:21:03PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 11, 2026 at 10:08:38PM +0100, Osama Abdelkader wrote:
> > n_tty_lookahead_flow_ctrl() accesses ldata->lookahead_count without
> > holding termios_rwsem, while reset_buffer_flags() in n_tty_flush_buffer()
> > resets it with exclusive termios_rwsem held. This causes a data race
> > reported by KCSAN when a PTY is closed while flush_to_ldisc is still
> > processing lookahead data.
> 
> A data race of what exactly?  lookahead_count?

yes, ldata->lookahead_count.

> 
> > Fix by taking termios_rwsem (read) in n_tty_lookahead_flow_ctrl(),
> > consistent with __receive_buf() which also modifies lookahead_count
> > under the read lock.
> 
> This feels wrong.  I would like to see a LOT of testing and validation
> that this is correct before being able to take this patch.  How was that
> done?
>

To clarify the reported race:

The race is on `ldata->lookahead_count` between:

1. `n_tty_lookahead_flow_ctrl()`, which does `lookahead_count += count`
   from the `flush_to_ldisc()` workqueue path:

   `flush_to_ldisc() -> lookahead_bufs() -> tty_port_default_lookahead_buf() -> n_tty_lookahead_flow_ctrl()`

2. `reset_buffer_flags()`, which does `lookahead_count = 0`
   from `n_tty_flush_buffer()` under write `termios_rwsem`
   (for example during PTY close / hangup).

`__receive_buf()` already accesses the same field under read `termios_rwsem`,
so this lookahead path was the remaining unlocked access to that state.

Because `n_tty_lookahead_flow_ctrl()` performs a read-modify-write (`+= count`),
`READ_ONCE()/WRITE_ONCE()` would still allow lost updates, so taking read
`termios_rwsem` there matches the existing writer-side protection.

I also ran the change with lockdep enabled and did not observe lockdep warnings
on PTY open/close stress.
 
> thanks,
> 
> greg k-h

Thanks,
Osama
