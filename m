Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584827E04C
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163506; cv=none; b=YqMGj7k+ay4/9pVL6bNAoc/446s//BzIR5TOFv91ypJA5unbS6wGootbyXXLBganIQnjdCIky+OXrfOoHCZUmoTqyUrDeS2hL3bK0KlUXz+OPVzJh7l/Ja8ghgv+dAC37pvBidGEw7iA42Uh2UpSdIYXmX0M+X+x0MtUqpJiyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163506; c=relaxed/simple;
	bh=TEcG6XhnpxQ/LbzrzUIpzGBT5rLlNzT5H4fF+5CC404=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7y8vGfkTgtmIS6e6OxaG4gPTgt9muLDVYVKkJ4NaxxQJ5KdhrXi0C/A9keK+aUax2H2dOCaR2MDp1o7z4m84Kizb7xCVpZhad50Wtp1GwnhONZENfRZ//bHK+1wnupJNsSvu2gjBlFBqBC3LmH36gn/cJrnuOZi8T27jwGm9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FB+M6qv9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FB+M6qv9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso3947304f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 05:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764163502; x=1764768302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0f4JQ430d3gYxGe5A4S7xjaYOrTUOg5SC/fVmpakeBc=;
        b=FB+M6qv9B5MEvc4DUXIZLaAc5dDtHLXDU2CQZ0GPwtybjBuAkA3a+vpDkH9gs8A8RQ
         IgkmVpyjfJoA5exr7VFa48Xe68Q+ByowoJPAEDTW1+jungifGDkVQTpSSqa4I3eWFPAe
         eFxmuIIANOpRde9weM48y7q8NsRd1rxYBToPyTnqKNAUqu102UMxTkFRU8T+65mjeqDl
         8qJXelxawzh8fc1IvYi2J078OdaNnkw+gch5RzeqUUTTqVxOB8Pu2acWt2g30UGVHvOu
         flOn2epSnp2hqI+kr92Zg6X3Trr3/m0ZjYDLpZd/PTAZK4jP89SIhqPs+VqeZd7W4Nib
         kzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764163502; x=1764768302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f4JQ430d3gYxGe5A4S7xjaYOrTUOg5SC/fVmpakeBc=;
        b=KPnVgF1Gs/R/Nwsj+E2LpnLcDL68cwbGHRCMa8mOETSbetlOVX9D2OZIrOnfRofN8H
         jg9eRTBlBlVaunIRA1515jH+dqNm1dKRvr0zQId4JCMIOvaTUV0ezqlxyJGP0zBq8/KV
         eBqIsMrwdcYX1ZBJH5B3X3iPlGBNBho9gsHTYDSUAZiWZzL6G1p4h/CIMLUn7VDvJ2DF
         gRd4M9onPWTqk8E5YF4dHgLqdo0P0Ou+nVe4ADpW/8UlbonjwaIdra6r+iEpwcSiudvl
         B/meDajE9FCSq9PQeC2pGOZ5fZDT1Nfm0oc7aSUvnsrWOm2QPuZSYGQ1qXS4/hlXVHjR
         XYbw==
X-Forwarded-Encrypted: i=1; AJvYcCWAP2bLTpUMxx+zPF816PAYea027MLingV6IP1K0bHnYTeEAN+oMJlxH9zHzdMRyVaWeWrf6ODDCUOIHro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Q/a8B3zSuFJ05wlQiyd6YJ6m8u4awHcBrtXSdnnuMFOJYhFd
	f4ZWsc3U6O7wIF5joWNBL696o6hlQ2PR9o6rCsiOu8zjWGO1zlyUDNftE59YZVyp4kM=
X-Gm-Gg: ASbGncvi63kIkcKvpt1PAr45Ib1FdzRhClhqJ8a6ubdtoN6alFgJ8F1RwI0mKtsEyQl
	bZwzKPRVZKfOOOQVzgZgmgV8ttpwITCd+r0SMDJuuVng55o8LfptwvOWGaxyifcvOJk7gcZsBmp
	ex9KMYuKKAhpJLzLP3B8LBpXQ4r8imM5Xj4OeiyeA9QTwmCvprGzXFPt8RXBiPe+u+ptvHW/pYi
	uyMHUMxc2JZ2U9NQvFfYOIHhMlA/42t/P5AJI97DhXDcVQ9L5cXxNYnVC7WjPiBqhY9nJGiXKjv
	fvSnprC7ZOCP9dTedK8b40v2o8ArKaP60FVUyHyg88/Fzw+yaKm0ihGLD40reixK0xgBhlOfZ6d
	mUEJBO04euFj0yeJjKe83vqI1cOkLzoT73kqdb5LUJxzZ9uzHdHdfWwZ/3RtBdtHFh+y/Vj2/4b
	11hotuLJjwEQCexQ==
X-Google-Smtp-Source: AGHT+IGt6B18Cfsh2aUtNnKQ/GdUe6r5HR9xnqzEThLvWMbBGO0PZDF86prVk/ruzgDmDAMG5bRFMQ==
X-Received: by 2002:a05:6000:310a:b0:429:bb21:94dd with SMTP id ffacd0b85a97d-42e0f35024amr7000231f8f.46.1764163501920;
        Wed, 26 Nov 2025 05:25:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8a29sm41169883f8f.30.2025.11.26.05.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:25:01 -0800 (PST)
Date: Wed, 26 Nov 2025 14:24:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 3/4] printk: Use console_is_usable on console_unblank
Message-ID: <aSb_qmjfNc1seDzb@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>

On Fri 2025-11-21 15:50:35, Marcos Paulo de Souza wrote:
> The macro for_each_console_srcu iterates over all registered consoles. It's
> implied that all registered consoles have CON_ENABLED flag set, making
> the check for the flag unnecessary. Call console_is_usable function to
> fully verify if the given console is usable before calling the ->unblank
> callback.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
