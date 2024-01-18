Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6F2D03B
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600675; cv=none; b=snZ182hM8DWFN9KpP3VCce6juABcOFGsIZ3eIYH4a95jnCVb0lFUVN9EjXgJvLoWsAvzsrCP6IHjP2ojfs0lDRYmUaslrl5ZXNeVmicUKU8I8od9NBjSkdUjRY4qZovyTNUKX2qfrqWuWg+2hMb666q9EnafNeirRVgPg8p1omY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600675; c=relaxed/simple;
	bh=/h4q32yEfht3o3V4KdfWWw34f3PK7YiTSBlwmYSS93U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=dQHLYzb1zES5DahOIcNM6pBsMvYozNfvWUtd0IkYdaA2HsTA9rKUtmP3VuaHCDh7eqh5VNXqTrXIG8XLefYppBw/cHmj2wgAkt/1NHwnMBDV0oHw3pfK12m5IibhURfSw3RdM/2YbbFK5TO9Na2Gq3dbXUXQAMZ41btcjAfubeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSmzQC1n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSmzQC1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705600672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k698Zj5WVi2wSh0ojlY5XsX33bGvDw0g7gHOdyMGiao=;
	b=KSmzQC1nUwcMrniQN9D/lcl/vqhT6/+SbFRdPOqx5oV7lAsLVKcPztXu5BFwgLkJrWW1Zb
	h1+g0FEpHlYmR7x4rJ4bnfqpK6IgPLKx0svqf4om0+yVw4qXzhlB3rhS1VLx8k7R2CVl0J
	1hel6XARo/06RvPABgC91pedA3uwTsg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-0vjNI4SGN-OsrVnbQiuIUQ-1; Thu, 18 Jan 2024 12:57:49 -0500
X-MC-Unique: 0vjNI4SGN-OsrVnbQiuIUQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d5b60c929bso74465565ad.3
        for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 09:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600668; x=1706205468;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k698Zj5WVi2wSh0ojlY5XsX33bGvDw0g7gHOdyMGiao=;
        b=lBhe13Gs/yriOrh7dkvZzby76rM5+u3/l3VN/5nzUpswIMYLlbW+fKcIovmJRTb+6d
         2Zcf0IGlEqydHy7zAg8rgNa6ovzUctS7Uj5uaLMARBI3d/CVnk7bQNWiZIEhDBLpg2Uv
         Xs8fMhpG06rciJ5JU3FsOQZ6GwIsKCnXXna2ZrCs+2Wmer3HoaUlKNzjK5mo4sckc/uv
         UWoSuM32gegh0naZ165Bb0B+BR2m5RHc59/Otu3AI8jUNlU3YxmlYGACjg5HwD3wbrrG
         Bgh3tCxbgQKDLgdOvlDABhaixqf7yCtK32ERAdFH8A57VUfrju+uyt2h25koGpQLnt2E
         vXhg==
X-Gm-Message-State: AOJu0YwFC6cddbchS0omaFrlSLFE9Yl9eJZGCPkXqXd2S9s63DNAeG3T
	LZylqkKTEJrt6/zxOVgZdU04kg8FhjBjZ5OpP0tQ/ysRE9uvjPftq1i2gWmVASckIyMY9ZmzjhR
	hK+yStqEHlSc1MVDQus7nEQW7pPpSbkYckAf4rwqZId/B6oyJqMPIs9rpCdVhpQ==
X-Received: by 2002:a17:902:ce8e:b0:1d5:4de3:ac46 with SMTP id f14-20020a170902ce8e00b001d54de3ac46mr1580964plg.3.1705600668401;
        Thu, 18 Jan 2024 09:57:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnebEcTPLHkFBmQ6EfojaCFD+NnXlGQNOks//6hkSo1dcU/+9i+KTj98r0E/eiyp7wduxGEA==
X-Received: by 2002:a17:902:ce8e:b0:1d5:4de3:ac46 with SMTP id f14-20020a170902ce8e00b001d54de3ac46mr1580948plg.3.1705600668132;
        Thu, 18 Jan 2024 09:57:48 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001d704c0d5c8sm1574966plt.113.2024.01.18.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:57:47 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Thu, 18 Jan 2024 14:57:34 -0300
Message-ID: <ZalmjpcqMvzlIGGs@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3632cc5e-f1d4-4780-a233-19bfcfe8af69@kernel.org>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com> <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com> <ZabJGefGkrs0SNzW@LeoBras> <87o7djaubq.fsf@jogness.linutronix.de> <ZajxMc05uVmK7e60@LeoBras> <3632cc5e-f1d4-4780-a233-19bfcfe8af69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 18, 2024 at 11:33:08AM +0100, Jiri Slaby wrote:
> On 18. 01. 24, 10:36, Leonardo Bras wrote:
> > I am using mainline (torvalds/linux) kernel, forcing ARCH_SUPPORTS_RT:
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 5ca66aad0d08..879c34398cb7 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1195,7 +1195,7 @@ config ARCH_NO_PREEMPT
> >          bool
> >   config ARCH_SUPPORTS_RT
> > -       bool
> > +       def_bool y
> > 
> > Since I was not aware of a PREEMPT_RT-patched tree, I did this so I could
> > compile a PREEMPT_RT kernel.
> 
> Huh, when exactly did you intend to mention this?

Since I was not aware of an PREEMPT_RT-patched tree, I thought that this 
was the vanilla way to get a PREEMPT_RT kernel running. 

TBH I did not even though that there were an external repo for PREEMPT_RT. 
I mean, I knew about non-mainline patches in the past, but I thought 
everything got already merged upstream, and any other patches would be WIP.

I understand this was a mistake on my part, and I feel sorry if this 
brought any pain to reviewers. For the future, I will be basing my RT 
work in this RT-devel tree shared by John.

Thanks!
Leo

> 
> -- 
> js
> suse labs
> 

