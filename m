Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA5446CF
	for <linux-serial@vger.kernel.org>; Tue,  4 Jun 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488564; cv=none; b=VmKBNkYv2hgzqtmYkQRoEOtsYlaNX6yAO6ZR+ISjyFrYnwhqZlnhSwngDM7GHTgXnnVF6Oh0JGY9ZkM8FGWnpD4fLCXIk/Ykh4oqh6EmuMkycZp157Q2KjQ801JroHcRKLnYtCnNumFTXKjS+VgpOb7LOpZbLD4vrGbUQOiCDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488564; c=relaxed/simple;
	bh=jsmPz/k1p+Y8GO04dOldgsBBp7w7NBWf3VP4rZu1Rpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hughMEK2tv72+vzLiRz775JmXGW3WdPUlTgQA8DjAfcR90v/oRsBgq2GW0PmcUxiqXL9xjbLVDDGVv8MWfZt1JBV4Qx81WauGzvej70QwRM/4XzOdMu4LWue0Qk6JMhOC3QUYC1gv3PE831PkUpDcqK/jihepektAn2phKLPF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ImsqvZgH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ImsqvZgH"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35e5604abdcso1210208f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Jun 2024 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717488560; x=1718093360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3/eSMbfH3GxJXiAeW4Zl8FzceN/5F/2l8oFwai4K1E=;
        b=ImsqvZgH0PvaFRrZjMzv1mC3zveA4ZqbO10BYTKfHu4VIgqJWU4tcWhOaLV8+NjYqx
         CebGsiucgo33qGJCJEDl++s1lLsmA4FqPnYsT0Emu5djuBswqVZkkkvuvRHkJDATMkEl
         8yRaDxuJb3kY/h/b8lMjpNdV33xnJAfRKtXfDf3aqJI8cmsSo/GZRmrKb4b0IPyUO5Vt
         iFxNolSnejAqqNp8BOXXWjNdncVmzypbp8GlOBEP/DC5UAHmtYP5N79ktjP+5vw0fvuo
         AiLyOCuXlQqY00GQBfwT/BGO87OfHgO7x9jxoZ4Cb2fJNhcfc8IUoH5ELeLiRpbkY9rV
         re1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488560; x=1718093360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3/eSMbfH3GxJXiAeW4Zl8FzceN/5F/2l8oFwai4K1E=;
        b=rtvS/XdHnU1U36Wk5gC36EAqUYYo/o2pO6pE7ezjxuKhQTWccTbMOhVyqlEdw8p5fR
         GKLFZRsmJvcD2theuxp2Je1Q0rQ75CJkgUlyrhs/WhIUm1hPt5Wuu69KTOmA9E6a1l99
         iNKddA119Nanxn6/77OEblSzHpT5CMukvwWvWBEYYKa9oq7rZA9SVRb3O483vx2d5ALB
         t++kzb8FbKvciggHfkxYiqr/7ehSOgM+tjglxPW9Es5UdR/Dx87njCyZYWBfseXYEDVj
         Sfs8bhEQtQjIFXVqWQOPt50laK+n09oOhoJFHxOKn+rctCp6mUGCgvm/WV76ZnvkCJip
         n50Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGF5we1RKyyYVjB1bwwd4dvTbR1aefdb6zLS/0eSe73UZc2937K3LpGKrD2iD7X8oQY1WTo3/+QPp4WZa2XnaH4jafwsWQglQPdKms
X-Gm-Message-State: AOJu0Yw4AkzCjINLD6N6jeUhqgwnKSAbdYpMz69gbKzggc9nlJ3stQdt
	FBhxTWaBxVdsndVBmPsH0lEEUUrTKUI0EDODs1ITW6xU2ZWAe8R9iX35PGYAMUM=
X-Google-Smtp-Source: AGHT+IE1yuIeQdvfaLUlHn16HLkz5ku2FV+gfSnKv2NqvwgiNpGtvNC3MCPso6YmvpVD0Etm1p+EUQ==
X-Received: by 2002:a5d:55c9:0:b0:354:de40:2942 with SMTP id ffacd0b85a97d-35e7c52d673mr1546703f8f.12.1717488559721;
        Tue, 04 Jun 2024 01:09:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6324167f5sm78117595ad.282.2024.06.04.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:09:19 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:09:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH] printk: Rename console_replay_all() and update context
Message-ID: <Zl7Lo5eGJKLjbTUc@pathway.suse.cz>
References: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>
 <ZlmPAZUeKIDFKLdf@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlmPAZUeKIDFKLdf@pathway.suse.cz>

On Fri 2024-05-31 10:49:08, Petr Mladek wrote:
> On Thu 2024-05-30 13:15:47, Sreenath Vijayan wrote:
> > Rename console_replay_all() to console_try_replay_all() to make
> > clear that the implementation is best effort. Also, the function
> > should not be called in NMI context as it takes locks, so update
> > the comment in code.
> > 
> > Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
> > Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> > Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> 
> Thanks for the fix.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
 
> PS: I am going to queue it for 6.11. It is not critical
>     to hurry it into 6.10-rcX.

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.11.

BTW:

I have pushed a patch which came to my mailbox with ID

   66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com

From some reasons, it is not available in the official archive
at lore.kernel.org. Instead, I have mentioned in the commit
message

     https://lore.kernel.org/r/Zlguq/wU21Z8MqI4@sreenath.vijayan@sony.com

which points to the same patch (same changes), exists at
lore.kernel.org but I havn't got that one from some reason.

Best Regards,
Petr
