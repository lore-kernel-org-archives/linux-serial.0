Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50223ABAA;
	Thu,  3 Jul 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536967; cv=none; b=IcgRi57hK/2ST8Zxcb3/FvJdGLmRqNEmLtu3aP4WwYQlf+in5REnvBGqSaVfgxdgR+3iw3k292nzdYrERTjQs898T5Ndlw0S5vZe59rA71U0+sdNpusuq0SWIqJAv1nIwMikGQKEDjpU/wLQoUP7923tV0ZkON2cpCcD5Cobcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536967; c=relaxed/simple;
	bh=Nw/LLCWjF+BPDHmbxNi3eWC9yqKHjgiMc9aBEX+VBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL85hklNBAxdao8UvwvuSW9O37p6d2F6LdEn6naqms3G/BgS/YUxfoz8QvXQ6ZZsBOqozpqhSEId+0xSE24Vq6SXiZNTHw0Tj3rq+rJbPK3a67iPfYa+G5Gd0W1Tlp2LUeBs8O7y+byfWuTzUcOkW/6jszkXdO/5dMZp3m2L8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso9038675a12.2;
        Thu, 03 Jul 2025 03:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751536962; x=1752141762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4/rgQkgha5X6rrJzoDSNGEpZWbIHMNm8Tn8er8cB/k=;
        b=TNcYER3r7NOg0YYpQhZjkGAx4f0mU8hgGANdbX8LJEGyldxv3/2i1c6zM9WYJXK+Ti
         PIyA4VSR0IynVQWliWMmX0zTvNNqiobuEG9CTVQRTeNXXl33fdvu+xHblsYhyxIU2p3R
         Gze96r3irfAx+TiqBMCia81R6iQGZvw4htMeuuBKjtIgDmiu6abR8W0m7TDTTP+GEpjE
         wrwR9A3rJsvJWugMO5rhX8H8tTmOJdljXe8pPawGqtWYVIv3KIaWoCcUSdOb8rZ8Jo6c
         VU4HiSTzyM7RmqL93mbnJPN1ZffQvP6Gj0icgP1CvOZs/sh/P9HhiVOPUbOOMGIdBwbq
         7onQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIApP0ttMAGI4L/gilaV4yV04vk8DYpYjAvaRsQXFy6I0pLLesSRNws6lm3n9S4gzllZ3hjttodNT2xsx8@vger.kernel.org, AJvYcCWFQ7QaAJ5gk1rHoCrQAKyrkVYVOB5TpuEuzpLbjDm7pHYiHrwnQBOu/e5J8fxqcpnZ20HNn5J3NNiLck0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14LxtYAIDY+BVjOOgpzv69YYOneHWUBlLq1G+1RnPzURl7WJD
	AJVW3eIbrNz7xZCuI0Y+8l5EYfAqX6ayBGNWPPaFI1Yt5z+M+c9qhV4s
X-Gm-Gg: ASbGncuWlGDnwhhynX9V2uoWLMjNTC41+9HbDOXR6jWwG4hyPTV9GtplNxtipb0fsn3
	87HOWTcy1G2AA7dEL44uiAZwzxiMLLdKMlNAqTp+n3P8Af9A08UGKV/4kbuZZ9KQ+t/nauZlHOQ
	EVhc6QF//0MQvbnlyMaaen+nb3i9vQwYS8fgfpzXWkD6TxAxo2JeuHRNWfBIk5h/HgjHjMvxDiz
	/yszDEKYo9nxpoQ3Od9d6yT8CI0+ZwXx6pnpylpq7xPA3bxQg7W+w0sW9rojhMTrb6Ur5cPefOj
	5b6gBNziSfjNaG9aFkdrafSpTLq/etrKlW3/fqqK4K4nTD8KRUqLe2hm+QTBT+G9
X-Google-Smtp-Source: AGHT+IHrcjexOB74PqvVv9z/9SXhAOIQ2YaJ+lsByNRtlO9RzJ58V2gP8EKrD/Tpey1DUiVDSp7PSw==
X-Received: by 2002:a17:907:eccb:b0:ae3:7c8c:351d with SMTP id a640c23a62f3a-ae3c2e35d60mr607661766b.56.1751536961821;
        Thu, 03 Jul 2025 03:02:41 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01620sm1250043566b.103.2025.07.03.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:02:41 -0700 (PDT)
Date: Thu, 3 Jul 2025 03:02:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Leo Yan <leo.yan@arm.com>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGZVP8A2a3VVQwzt@gmail.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <20250702172036.GC1039028@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702172036.GC1039028@e132581.arm.com>

On Wed, Jul 02, 2025 at 06:20:36PM +0100, Leo Yan wrote:
> Hi Breno,
> 
> On Wed, Jul 02, 2025 at 10:10:21AM -0700, Breno Leitao wrote:
> 
> [...]
> 
> > Further debugging revealed the following sequence with the pl011 registers:
> > 
> > 	1) uart_console_write()
> > 	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
> > 	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()
> > 
> > Michael has reported a hardware issue where the BUSY bit could get
> > stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
> > bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.
> > 
> > If I am having the same hardware issue, I suppose I need to change that logic
> > to exist the cpu_relax() loop by checking when Transmit FIFO Empty (TXFE) is 0
> > instead of BUSY.
> > 
> > Anyway, any one familar with this weird behaviour?
> 
> To be clear, I am not familiar with pl011 driver.
> 
> For the first step, could you confirm the UART port is only used by
> Linux kernel?
> 
> In some cases, if normal world and secure world share the same UART
> port, it can cause the UART state machine malfunction and long wait.

I don't know how to check it for sure, but, looking at the serial
console output, I don't see anything else using the UART. The only
output I see on the console at that time is coming from linux kernel.

Would you recommend any additional check?

Thanks for the reply,
--breno
