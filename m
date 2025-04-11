Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AE35946;
	Fri, 11 Apr 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377503; cv=none; b=dnPcmPRft3yOZBaPzCGrqGDHtr8TEf0AzoDkvNUX61ESGrNzPAs6Lu2MCM5q6LqOPG7oym6qyX85KJvpYjPuINaA9co5ivy7oxN43VTY4ohB/edPEkVzcxn62lUrq8bUX4qxLCb5aYslZEuCxm1eyrJujNzV5tmyHTjOrKtfwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377503; c=relaxed/simple;
	bh=IeI3eSeAL/MoeRlrl2yOI3hGBvGPXUPVq1OPhKbWqkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgiU9o2qkcVsRBkbP2E+jJm/VHkiLg86JyQHrhlPTb3FX3CeXucT4ghIHGxMLIXkbQR5DiWpuZqalXqk2J4jVv2TIwCNdDmBl5ttPHwaArq3JkAmwvB3YB2QFO8TChKyj4D4RJz9Sw0DCkRpldbTKsQQOvSQmi2IvwjkaUB0Cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8hcrf6t; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8hcrf6t"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739be717eddso1483942b3a.2;
        Fri, 11 Apr 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377501; x=1744982301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MA5L9R0Nf5HUBvu/X2l/N9S6FUK2IdgYTVoNXD7ORo=;
        b=j8hcrf6t/XlVFpkYBdtHvdm08nzBLdpYw5RBOU8YJxOG9rsAZGrtUDBfvPQp4XJ9gq
         L6FZuUI9vJ5eCLY6pFyaCrjNt8eOhQcUt46u8M/VM0Suz3q6izMKUEZnjZmNapGKxTsg
         HlGSq2Zy/wZk1uWUZtNLIYMJis5rS99d61COPs95SGklYW2RdJ8W/bhvNi62etJ9DBA8
         8d53AMKVAbyh6e2t5QGV7WBueeSYCbWx5UqTDy4OGrUFNZfzgFmaXU+3f1QgG50WzgH7
         63SUEp14f8VSqrcbzRuVyV7Y7c1tcc/TRureTNV4tQGr+urg4p9V7dTM2XjZVhMlTjAs
         CiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377501; x=1744982301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MA5L9R0Nf5HUBvu/X2l/N9S6FUK2IdgYTVoNXD7ORo=;
        b=DgjfBj8TJZTxyXLvrg1PlcV/gkyaeSu+BpdROITGY5qYQeslw+BFZu/f+fPgISQwJm
         O17IPoVO29Xt+F858rRfC3nBA2mwADNyJUi1pqj8vlI8jV1CRyyE71LbGbbDiNPIW5CZ
         /kaSywrXqaqeehjUASaiqRoREz58iFySImaiuWC3uJZg/755iFb8Up/H1TOdM+VRsbwo
         JjV+i631eySiRuQwPjx+xX4qGNSUaUQ8OwRVWpq3bp+tcVtoUOPTRnCVWfB2B0psvAGM
         homC/0z7UtKrl/FU03NKuXHWd7G9QlA4xGbKmtR8y/lA1Jtepz29fhwqbeXAnIcze2FD
         hTXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqtpVXbrO+Xztgugt/ilSFDCXabxzt7MxUonlAoqF5+NjAkYHF8e+Nf50Qx/2f6vdTDujY+KCh/KxGqqc=@vger.kernel.org, AJvYcCVP1VaCDFNyeM3+jvLG8FH8QykpYY0tOTIEOca3zlOvXH35/n1UvjsDJ7hYuMsJznMd5F/tkNARqXvlFTSu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hQZc1Ah4N8nQu0gZ7l5ec1SbBwbAYCZxoKKnlnvInLT6Q2qa
	EWbhxGNcqOeZ+UCk8j4bwTTEkGrLojBqP1hFTBjitNsrMd1lxyDM
X-Gm-Gg: ASbGnctaIFBOhRNvlm/gTRwSqiLsWhhZycBjgDy+2mvmrdSNDKYIIDCfoLBtEsUne2o
	bUbHxdhE6lfY/Ibmjvmi6I089WTGDlX08Jo7YKyVaHwdz8Sfmd9+/5mzQIyplEJlE3f20chMbKf
	zTo2asnvuoqpmbfR/prI20XsSGfnhVpFS0Tr3EST7EmGIa2c1LK9+s6MTp3fm4f2aBF++xX8ah6
	ucRJZHNLh2RmYQS1UWfGKS7C2wPPYuTckIIvt2G7Pc0yCoiWAAhDGkCBOBUzG5KwZc8BKpynxLY
	J9lLWyBwGErfAVfw8yrR0XkxmgJ444uEnZ5mJ56sXwvIEg45BQ==
X-Google-Smtp-Source: AGHT+IHh9ALpWW2aR602qeuewomF8oAjCqp7iPCudPX2N9HrVhUM+2LF030dKHxB43SWhnuH7ccwfg==
X-Received: by 2002:a05:6a20:ce44:b0:1f5:8754:324d with SMTP id adf61e73a8af0-2017978a754mr4840372637.9.1744377500682;
        Fri, 11 Apr 2025 06:18:20 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2bbfsm4705583a12.41.2025.04.11.06.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 06:18:20 -0700 (PDT)
Message-ID: <641cb805-b279-48af-a3a9-492a8738c841@gmail.com>
Date: Fri, 11 Apr 2025 18:48:13 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: keyboard: Fix uninitialized variables in
 vt_do_kdgkb_ioctl
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, tglx@linutronix.de, hdegoede@redhat.com,
 mingo@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250411111548.31399-1-purvayeshi550@gmail.com>
 <2025041107-postbox-bonanza-2049@gregkh>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <2025041107-postbox-bonanza-2049@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/25 16:58, Greg KH wrote:
> On Fri, Apr 11, 2025 at 04:45:48PM +0530, Purva Yeshi wrote:
>> Fix Smatch-detected issue:
>>
>> drivers/tty/vt/keyboard.c:2106 vt_do_kdgkb_ioctl() error:
>> uninitialized symbol 'kbs'.
>> drivers/tty/vt/keyboard.c:2108 vt_do_kdgkb_ioctl() error:
>> uninitialized symbol 'ret'.
>>
>> Fix uninitialized variable warnings reported by Smatch in
>> vt_do_kdgkb_ioctl(). The variables kbs and ret were used in the kfree
>> and return statements without guaranteed initialization paths, leading to
>> potential undefined behavior or false positives during static analysis.
>>
>> Initialize char *kbs to NULL and int ret to -EINVAL at declaration.
>> This ensures safe use of kfree(kbs) and return ret regardless of control
>> flow. Also add a default case in the switch to preserve fallback behavior.
> 
> When you say "also" in a patch, that is a HUGE flag that this should be
> split up into a separate change.  Please do that here, don't mix changes
> that have nothing to do with each other together into one.
> 
> Also, why isn't the compilers noticing that these are uninitialized
> variables?  Are you sure the warning is correct?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thank you for the feedback.

Got it. I will remove the default case from this patch and resend it 
with only the fix for the uninitialized variables.

Yes, Smatch reports uninitialized variable warnings for kbs and ret 
because, in the function vt_do_kdgkb_ioctl(), both variables are used 
outside the switch block but are only initialized conditionally within 
certain case branches. If the cmd value passed to the function does not 
match any of the explicitly handled cases (KDGKBSENT or KDSKBSENT), then 
the switch body is skipped entirely. In such a scenario, kbs remains 
uninitialized, yet kfree(kbs) is still called, which could result in 
undefined behavior.

Similarly, ret is returned at the end of the function even though it may 
not have been assigned a value, leading to unpredictable results.

Best regards,
Purva
