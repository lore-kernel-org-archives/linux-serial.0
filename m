Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B7343888
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675672; cv=none; b=URMlHww+AnIObWg/22K3s4uTEBZgbB/NyTf7b4xVqnO+bHlNmqFlGyyBEvACC5NhSdFigsnp33g1F+FyXJqvmhWZ3wVD6iLI5SB6ZBdxzmIctGkOEbRXi4aHPgQ8HLk6aB4bQIpre3ilhOUoRNxjp9UH8qt9VQXIdjPUHxti7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675672; c=relaxed/simple;
	bh=JPSEZ5DBfGgXCMRrMt7tkKE0iaKqNP+5j0HVvURBbbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=agFaF6gLUxbbJFtcNyOa2vjJJ0YrQW1G2suMr/kdt9zkcg+/f+Q68pLgcnE/PPe7z1HnSyL//gqHaRUAgUDLm0nGEhZv5cnf/sGdRMMDyx1igObEPdw1qeBeahrMvoBo35XAwhdUTOI3OTDBoTUyQqHr7VE6YtE1IZLnev9RELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ2BYWGM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ2BYWGM"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30bd59b6eb9so420624eec.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781675670; x=1782280470; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgHWRJeHkWZRclnQwk3a2RIt682Ls8zcqusIx8RTJdE=;
        b=MQ2BYWGMh6QLCDsqL8KDmQK5BXhbObmHpPKhYW+1aIncnUo8bvUqrN3JhjEadylnFt
         wz2B3p4THdocXM7AX+G7OrtB9Ffgx1D0kTRujsa1XE3Ls8Nr46waqD4xqAdEa/i0w8/A
         xpmnN7erR4fpRY6NBMhxNWCKRxV/vFLUaDcd9Mojh+/zlnflijkmNcuG8MvlN9g/Jrvg
         UNGawByMbN7Je/Bi8lxsA9kyGRJHYbywN4A68aGC5CxJLbxLAjjCkMr0/G2/x8N/N1vC
         KbXcn+cB04AzsuOpu2pl4HhSv/lKYcAxJQHboImdQnO6ovbM/1oA4+KNlWllKFBkVeb9
         aEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781675670; x=1782280470;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgHWRJeHkWZRclnQwk3a2RIt682Ls8zcqusIx8RTJdE=;
        b=n52EFtyOkjjBSg935DJ0oj/GF1dkXS9OEuRyNi3fGnHC6vHIV7XNae0bjM4qh+k6i4
         VzBQ8CBgwrEHKJXNFj78XgKhpq3TkLv0m7gKMG7rBPv0LLJH/ewyPm/Q3FJq0ix26J8h
         /CoxOFVRsbk46rFBeUPF78gFZrMdX9p66+rIlKhp1qaSSyuynd48K+8SyTFor7xsNpzI
         l0AiVAOUaug/dnqnXhhCudCR4uLvHyi4KZHfLRYnP2nhBS5daLUZWbKGlrthlVBAjOX5
         1UsBFfR8kB/vUpGmiiFqK6XmDr99Y9MG1uyjimfOb2YQhPo4by1fjmeiu/2Xj1gI0oZP
         Z+EQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VlZJWz/6HVb2XWnI0tf0tIzk9IACfhMTxP/aqVxsKy7MwHoqsG17efwzPvunOrfSylhKO6ATkKw+Ct7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZJTubj3z+ZR8qNQlN+YTVCMfTlLvtB+o0yAVPMxLFU0PlkPN
	dS9FA5cKCkLH61PUnJ2Y2RdvTl7Z/+Lctq0Ocn1riyBikVJRSRCWGjMP
X-Gm-Gg: AfdE7clQOwRrVCiWRhRt0dr5OIq/Ky53uu8rvAVxg2oR5fIYCo+FZW2R2FtDbPTWX+9
	BS8Is3KTI94Ec1gdpVf9TL//h1LAOPgWl7dSb70261BhklHp7qdzmSoBax5XEciNy7q4eSRE3It
	swI1MV9ttwywbBbYQ0vs2YSdjA3nn1OxtheqBhTUTDxlUZ/1tYBTs42MZeVul7iMcNAIOhxfcKv
	YNNVcOuFacxxYPkAJ/FO8TfYJLkTRx6tpWzbSjLvyq4OpnyZn+VclYM4jtfF4hz/cm9X+Wsw9Du
	pGMSrpavgtjo8ec/l0hg29KSJx4n1m7sAk08PVmDJOUnq8MOzKCBgdZJmIIUg8jHq3sVHeeVy7F
	g0nbdCnb+xZbQ01S5X2kVA0mDELJGv3q3Tf3ncnDRyckV1xF1kA4RsYx/A47mdmfYYgpv+ZhDi7
	a7T3n2Lm/enuYtIYTrYn6KkHAcpVzK9z8m1Qd7dyze
X-Received: by 2002:a05:7301:10c5:b0:304:6d18:3646 with SMTP id 5a478bee46e88-30bc917139dmr1162248eec.0.1781675670206;
        Tue, 16 Jun 2026 22:54:30 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm23558239eec.10.2026.06.16.22.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 22:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 13:54:25 +0800
Message-Id: <DJB3B9GN52TI.P6PBYUEDRQW2@gmail.com>
Cc: "Jiri Slaby" <jirislaby@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 "Starke, Daniel" <daniel.starke@siemens.com>, "Xiang Mei" <xmei5@asu.edu>,
 <linux-serial@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Weiming Shi"
 <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260616173240.3665059-1-bestswngs@gmail.com>
 <2026061722-explode-predator-59f4@gregkh>
In-Reply-To: <2026061722-explode-predator-59f4@gregkh>

On Wed Jun 17, 2026 at 9:24 AM CST, Greg Kroah-Hartman wrote:
> On Tue, Jun 16, 2026 at 10:32:38AM -0700, Weiming Shi wrote:
>> The receive worker walks gsm->dlci[] without gsm->mutex while a
>> concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so the
>> control handlers can dereference a freed gsm_dlci. v1's NULL check only
>> narrowed the window; v2 fixes the use-after-free itself.
>>=20
>> The fix pins each DLCI the dispatch dereferences with its existing
>> tty_port reference (option 2), so the data path stays lock-free. See the
>> patch 1 commit message for details, including why the late destructor
>> uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
>> concern).
>
> Cool, but wow, that's complex for something that will never actually
> happen in a real device :)
>
> So do we want to add that complexity?  if so, why?
>
> Ideally Daniel can verfiy this change is ok as they are the only known
> user here.
>
> And thanks for the test patch, but that's just a functional test, while
> great to have, and not one that can actually mimic a real device with
> its timing constraints, right?
>
> thanks,
>
> greg k-h

Hi,

The complexity is just the cmpxchg() in gsm_dlci_free(). The actual UAF fix
is only the tty_port pin (dlci_get/put) around the dispatch, which doesn't=
=20
touch any fast path. The cmpxchg() only guards the teardown+recreate case=
=20
Daniel mentioned, and isn't needed for the UAF.

So should I drop it and respin a v3 with the pin only? The use-after-free=
=20
is fully fixed either way.

Daniel, does the pin approach look right to you?

And yes, the test is functional only (pty bring-up/teardown, no timing).=20
It's the base regression test, not a race reproducer.

Thanks,
Weiming Shi

