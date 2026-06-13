Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17238423D
	for <linux-serial@vger.kernel.org>; Sat, 13 Jun 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329063; cv=none; b=RYEBjMhk4yWFHYJHBkYV6NoRMr1tu2aFTCn+AfQA9ftN4rjVrIrEGwVQ90couxWcRa8NIIEssFCyBMAoNeK0zIfhaVkhepWLvms25heGrs2rqRiZqvBBDV8qN9jrlq7+k7ioO29sAMpJNHtLkATsz6gnm2vj1O1r8+j7THQadpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329063; c=relaxed/simple;
	bh=bHYaOWAgoRhJfM84u+7bKWx+ocxa1uOn53TdvsclGgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pbGrsTeW7fLQiCDX/QIkmEgpr0fcguK5yUXM8qvZRmdwszD8PywAtZ6WrZBUnDfLsmfVlH2Mmt35Wrq5cAIjSouvqGzxecnS6Exa/wDpKlc7LE0k5Oci8aSFzpga3FqSxmLM+PUH2mycOJorZQ6I6QtwKY2WwzhRehKuv3lvoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKQU9G+o; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKQU9G+o"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304d8362a58so1329288eec.1
        for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781329061; x=1781933861; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsaGcYhoo/YYrFWN7u0fUgrvbDqAh/4pjfhWn+vABjY=;
        b=TKQU9G+oQt2AzwrGpYBOZxDr3/c6TT1ZmroMOxQbnkmSPEo6xfT8IwkqL3hxOUmLDQ
         D5H7Q75zdyqI9RhhOIZHVltpqQbRRmxjiBhqjFLXI/CmLGOMqPnktnGn1eVplQ/CqoFY
         ivZOMJ4lu1nasTFVlVdImiImBKVxLyzdkqCtypuHKSWz+5HJr8pXg1tZoDTmll/eL2xK
         H34Yq2cH98RMgYay31i4E+SUCEplO1Gfk78AtXcYhVPPlVKklYQaEs2qzTgZMRrxt+G6
         TrtUeTcB4hQF9ANwUxm2ldwfudDysKrYT9dZ/M3JpjMXRY+llZdsOcLbm6YOwwat52zz
         eiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781329061; x=1781933861;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsaGcYhoo/YYrFWN7u0fUgrvbDqAh/4pjfhWn+vABjY=;
        b=TshHbpl1lBGSUIQytQHT/odEjNAYLIo43GetZC9wi9odToVec+El03k5bCfvPNhetM
         ajvO2OeSXufINqQTi+js4zZ9WjYPopO4D+ehV8rMxyWnMoM3dIaaHvkXGoIQ3RdR47p2
         YBit+fy4N+inkf/CE/SLyLR9tsn0y4JGi9qSiV9Yw3skIYx1z3zxMD9is0wUNRATk27F
         /MN3zxA/SIPHsFUob295dJwzme8Uc15I0WKKoXrXa2FkemRYhTmYNCT7rBHPJSxcI9GS
         K8w2uOZR67A03OwKwxuE6g/F343LQO0UVmJnlsa1Z60oZThcj+AZf5S161vvQVRbUF61
         SOag==
X-Forwarded-Encrypted: i=1; AFNElJ+ucKI2/8WWD8pkeJmsGBFY76zHxYCP3+ZWJGWmmdWD3W59zQSL2ccKSWFOXwLVjChhvlFD1VQKbv91cm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxff3maByGzlGxn4Zx84jOlCmcUnN2nLKrGOBlP2FAxuimOZfbg
	FL+0dDwvJgt8zEKye3amEbTC2OAR8dISWqDKibW1gGe4g/lnXfmsJUzD
X-Gm-Gg: Acq92OF5F16PhBi+xIr4Y3cq7JncqOQ+0M3g21GhcwR/+VB9fWbO6r0N1dz6WYFoIKt
	yz48AsS/MkYUrCyS8EtttKHz7oqcgy5rnf6VAfhhR3v2+PSXl5Y9+z9YC8QHPECLzIuZL+biOcR
	wj9m6m52G9fmY3e20Jl1PvpA21fQ2EJ86Wz75ykU6p7yRSP1UYmFiUL684BAzr6IWIk1cELlsWj
	Fww+LhkuPg+MH74L2MWfUYEPC4N5qEt1f/4maw6KwDIc/OqTbnOkPWYmit80skr/157YD9CU6B/
	/7C4D4DDdogHn3f5tIAWBXx/JFc58uVno9TIMriCF4lPoTMUQEw6hG2UEyl4pL2lrRLQi6alR2H
	GjAWHSBOghJar6VJDiscAqUEcpmOkPN3M7OLFkWbdm9tGhMAI8sWx2rnqmUHRJ2p1wd7F8luk1a
	DA/B4u4SmDyJzbmwhiHRKxe7dQ+o4S+b3FSvSxsmX1duw6LVWs59Q=
X-Received: by 2002:a05:7301:19a6:b0:304:cd0d:9ea5 with SMTP id 5a478bee46e88-30820c2d295mr3279201eec.7.1781329060947;
        Fri, 12 Jun 2026 22:37:40 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm6138704eec.19.2026.06.12.22.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 22:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 13:37:36 +0800
Message-Id: <DJ7OG7DECH0U.NUGR9GOP7EP2@gmail.com>
Cc: "Jiri Slaby" <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH] tty: serial: core: fix NULL pointer deref in
 uart_resume_port()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Weiming Shi"
 <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260608165223.70148-1-bestswngs@gmail.com>
 <2026061238-utmost-amusement-4664@gregkh>
In-Reply-To: <2026061238-utmost-amusement-4664@gregkh>

On Fri Jun 12, 2026 at 6:01 PM CST, Greg Kroah-Hartman wrote:
> On Mon, Jun 08, 2026 at 09:52:17AM -0700, Weiming Shi wrote:
>> uart_resume_port() looks up the tty device child with device_find_child(=
)
>> and passes the result straight to device_may_wakeup(). device_find_child=
()
>> returns NULL when the port has no matching tty device child,
>
> How can that happen in a real system?  Have you triggered this before,
> if so, what hardware does it?
>
>> and
>> device_may_wakeup() dereferences dev->power.can_wakeup, so a NULL tty_de=
v
>> faults. uart_suspend_port() already guards the same call with
>> "tty_dev && device_may_wakeup(tty_dev)"; the resume path does not.
>>=20
>>  Oops: general protection fault, probably for non-canonical address
>>  KASAN: null-ptr-deref in range [0x148-0x14f]
>>  RIP: 0010:uart_resume_port (pm_wakeup.h:84 serial_core.c:2477)
>>   serial_pnp_resume (8250/8250_pnp.c:522)
>>   pnp_bus_resume (drivers/pnp/driver.c:234)
>
> Is this a real oops, or a made up one?
>
>> Mirror the NULL guard from uart_suspend_port(). put_device(tty_dev)
>> already tolerates a NULL argument, so only the device_may_wakeup() call
>> needs the check; the non-NULL path is unchanged.
>>=20
>> Fixes: b3b708fa2780 ("wake up from a serial port")
>> Reported-by: Xiang Mei <xmei5@asu.edu>
>
> Where was this reported?
>
> Why isn't this cc: stable?  And why hasn't anyone tripped over it in the
> past 19 years?
>
> thanks,
>
> greg k-h


Hi greg,

This is a false positive, please drop it.
Sorry for wasting your time. I'll check reachability before sending anythin=
g next time.

Best,
Weiming Shi
