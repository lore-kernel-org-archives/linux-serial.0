Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65913FFC
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028427; cv=none; b=blYQ+hisQ1iu8SmRZVf9Q+XCAo2lIPtnN5SLTrncmToz+30iPxAIKJT7ei8CVfg4uI6C/SdBUrWiob0blTvRaYdJgKH9KrIOqGd4QD5jU/i0zEEDQEkANg2O66/sDQH86X/CasP6id9Lm0l6kPXVPN5th0iBNYLUvXY0HveWBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028427; c=relaxed/simple;
	bh=zeHWontwHTd/NI4pX+2gW5Fw1q4DH4KwttEvVasE0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5sSOj6FJUa9s9GKYDrQP2Saj9QxrRUCNiJ037VIW23dECUUuJpnGlISQAVr3ZD1HMame9u3xrSdNIYhrdh4X60zU9eO57hcTjEbr/OHMw5yYxdemK7A1hQvFGDGME6sFhCSdtUN9gFAByNPNCkWE952hJS63khE05IBCedbD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=qT5Mo5yL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="qT5Mo5yL"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so189885a91.0
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 17:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731028426; x=1731633226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vojMdALZ39vwtHBszmMZroCBITCSq9d1wu4bY+CRc2o=;
        b=qT5Mo5yLeH4riT9hN8gETsoSeom+aMtac+ZPkiDEpHAnNthUaRJRjGTAwg01dmKyob
         ZadyJRdB/lk/VhQOZgtF5uoYRacEuzE9taUsyrOH8qfJFHxrTKTqjU0u4diFlsGboM0d
         XFC0PsdONcd27OWagCrv+t4s/UKYUFCmKkAY8RgMS7p7rtvdJLgmzTpoHwCvyjeIe6Y6
         XR9irZEVOBw/PT8m7qTEoZaQzppe+YdNKZd4+tMhPyVT34/m78UBQhKN0DyyxIIPjX6i
         0I5D9a5YPXfU4KzVg1Jq1IN4dLCAGSm/b3SMQzj/ECxfBuqC9HcwovTxsfse0yQ7uTgK
         zJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731028426; x=1731633226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vojMdALZ39vwtHBszmMZroCBITCSq9d1wu4bY+CRc2o=;
        b=LXhGmVJ8MxNp2MQW3aEX0XNT+m2dZ9TPMif1thUgaaG7QXPvABrrxXlmJQsD6ItYCA
         rP8qZHzG3G6OguOKej3HRFx5J/unF/RRgHJyDfyiZX+tZwyUwpjMfuWRe+qEawHfufUJ
         K0HMnaUZzidXH3aiSmK8x5R6p57qjleqNiUmF96eOrgJYLenAuJF9ui7lKgBFrrbHDzZ
         YvIPhpPSKYrT03qvcmbGBaGzSQ0GtV5mQMWFm48JByCQ9122FGEhgsTqRQK/wct326hu
         f+kqwqy2h4L4PGpQWgKNDSmz0YlCCjVl65iAC1dq9n6NiwpnppBuJhiFl7j7JydEq2nG
         34NA==
X-Forwarded-Encrypted: i=1; AJvYcCVXnNj4rLrG7+/wsNtlmmnwbzrQupIVBppgHx88ydRhwWRsl7X4c5nQILPzsO6BEH6ufzn1njGvStFIhs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseEOUQFslwlnBNpm6dKjvMVps2RhW4lA+AcfnZRqbY0ruZGic
	qKuHgSV3TMlFIfBGtgPyW7pbv2wVzH+hggshtMW4uX0LISV6jc/p9BmYDLNmAlM=
X-Google-Smtp-Source: AGHT+IH21ltIpBPjnrRcYJWYLm4UclJcdDvZJUr56kqpFJO6GDKOCxS+TGm7zeNIo6h3U62NB4Geeg==
X-Received: by 2002:a17:902:ea0a:b0:20c:f648:e388 with SMTP id d9443c01a7336-211835337aamr6302515ad.7.1731028425594;
        Thu, 07 Nov 2024 17:13:45 -0800 (PST)
Received: from telecaster ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fee67fsm2228985a91.49.2024.11.07.17.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:13:44 -0800 (PST)
Date: Thu, 7 Nov 2024 17:13:44 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Amal Raj T <amalrajt@meta.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	linux-debuggers@vger.kernel.org
Subject: Re: kgdb replacing newline with CRLF in custom query response
Message-ID: <Zy1lyACVnZK4xwuW@telecaster>
References: <Zy093jVKPs9gSVx2@telecaster>
 <CAD=FV=UZKZ_RL73+JLjeW2FmAfifSyXqLV3M30XzmJSPE9Trzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UZKZ_RL73+JLjeW2FmAfifSyXqLV3M30XzmJSPE9Trzw@mail.gmail.com>

On Thu, Nov 07, 2024 at 05:08:58PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 7, 2024 at 2:23 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Hi everyone,
> >
> > Amal is working on adding a custom query packet to kgdb for getting the
> > kernel's vmcoreinfo. The rationale and details are available here:
> > https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet
> >
> > vmcoreinfo is about 3kB, so we were hoping to avoid hex-encoding the
> > response and doubling the time it takes to transmit over a slow serial
> > connection. Instead, we were hoping to use the escaped binary format,
> > which escapes the characters #$}* and leaves other bytes untouched.
> >
> > We ran into a problem, though: vmcoreinfo contains newline characters,
> > which the serial core replaces with CRLF; see commit c7d44a02ac60
> > ("serial_core: Commonalize crlf when working w/ a non open console
> > port").
> 
> FWIW, the problem predates that commit, but that commit at least moved
> it to be someplace common. Before that some serial drivers were
> hardcoding it... ;-)
> 
> 
> > This effectively corrupts the data and causes a checksum
> > mismatch.
> >
> > We'd love some input on how to work around this, especially from the
> > kgdb maintainers. Here are a few options, in descending order of my
> > preference:
> >
> > 1. Disable the LF -> CRLF replacement while sending binary data.
> > 2. Escape the newlines using some other custom scheme.
> > 3. Give up and hex-encode the response.
> 
> I haven't tried prototyping it, but what about moving the LR -> CRLF
> code to kdb_msg_write(). It would be really easy to do this in the
> case where we're doing "dbg_io_ops->write_char()" since we're already
> processing character at a time. It would be harder to do this when
> also sending the output to the various console, but may not _too_
> hard? You could loop searching for "\n" and send all the characters
> before the "\n", then send a "\r", then send the "\n" and all the
> characters up to the next "\n".
> 
> If you did this then you'd lose the "\n" to "\r\n" combination in the
> gdb stub, but _probably_ that doesn't matter?

That sounds reasonable. I was concerned whether this would affect
anything else using the ->poll_put_char() tty operation, but kgdb seems
to be the only user, does that sound right?

Thanks for the quick response!

Omar
