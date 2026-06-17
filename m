Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28713ED5C9
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697360; cv=none; b=e3+T8gTAvklRoZiE8h3r9MIQ1HQsArOACmqMxKGL1Mgvq+7K+M2NoPXWy3KxT7mHMfJuckZjEuHWR52sgDtEkt8oiMln7Ds2bcQXoPtkRmyXD41woFBr8CgmBWxOHbG6lCkDTtpy6DMmEKP4BjR1GL6zU2fRD/TF0xwQ9RJfuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697360; c=relaxed/simple;
	bh=bsVKcHP12CsAygE9OlX5KbDT6c8JfJq9fzPsfTp81Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIc5N9lGrVPIVA950dTltrzF4DmTb0ljaXCw/2EqNTWt/izY0vbv73sVFqXCRBy+YtYTmtr8aHoQSFBg6tRiclX6vI321jQBzOY5F28awwHhOVGlNhuHYIzwR6Feb1820/G2IOaVrZQ7H8VcOvwrli0KKWVxtXZi/b66/RVMg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaDKIVMA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iP52uDvM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaDKIVMA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iP52uDvM"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8Ulaa1607945
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmGBvbELWd2AhWIWMgMsY6iGu2hpb1fqIaBTUXwLFCg=; b=SaDKIVMAVi4LQa/C
	ZmZHGrsZMRtFEtz6ozRsM+Qupz4BOADEwl/jbYblhUrwjUtfBNw3itkk1I9NK2tf
	zqQx8nLv1DAoz/6zT4QbKeHAZf6GkwBDTN4NTHya+0UrGQBNESHoDZbBN7xsQQJ7
	eaqHaFVSOeGYmYi/iHBkJaV7ARM0+pePmoTegMzwDunX9TDkh+tPhKAeJRkygLCS
	N93jDCDYCgUD76lquWgtazcJAFeDFhKEyQc7n9RIeO52dz9tfex2EGTN9XqRFu1C
	aqVqklCz/vkh5qtXNxjuhw7lZ/ZhdzPlfN1pH6fp2xSHA6PEOaLcBK+V+QxsZK0U
	EDarmg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef22xc5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:55:57 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-726a0352f82so379594137.3
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781697356; x=1782302156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmGBvbELWd2AhWIWMgMsY6iGu2hpb1fqIaBTUXwLFCg=;
        b=iP52uDvMUSB50Ev3OTIY+q9gRJoBlcU1SJmwxnEvA5xDPs3YwtN+GPYU2wr4zOC4Rh
         2dWrtwwE3PvMs965phP2WWCIoNYI+O1fc+njcnzJ1LvkG7mJFchlwM4ZAu1qLRleYUAn
         vZMC03JLFE1m004OvPSzmWYmKh2Q8Ay66CQjrpauMeTbSEnTb5pO5hqVrlpdjFJTrNjO
         8Aw4CeXPdBglqLbwOgBQy8XUzpm/5flieU078AYrRFLRoB01jUU/YWd0X/G7wxfnfZr6
         6ZlozTgUrQ2EfZgLKakbqi2aoP3iB9+SoLXJn+/egYODg40G6Tc0kRBtezmHPRMjaHyE
         27ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697356; x=1782302156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmGBvbELWd2AhWIWMgMsY6iGu2hpb1fqIaBTUXwLFCg=;
        b=UQ5j224GZ0p4nbbw3aQrXFVocHgdBDFQrBQqmhX01RLCyZthE2JYWA4pxTwXq++jO6
         6NcnIljTnYo8iPkHINvZoypjj4pX3DY8nDElov7lcG9GGsJ52lYLFcAyLBzSNGTPH59k
         gUb3ZILCMpiBQhehvp47ulnQwOFqN4OGvO6FyP1djJW+2aZ23KyCEJmpntP1NOw0Nrey
         K1jV7Kb9WAOzt45FPZEQOpKTIBYS0TXacwEvNVpiVIwUnw1fL4ivf9B8vF70QKk9vXLR
         /KQ4hy9ew5n47VoNrBrdqy8RHzTaLV4rP6jObHV0aRre02iIT5O/+nDNQi5djbp+BLqh
         uChQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ftZybA2C2LdUvMLNtO9TK+bYr+1L9Pi4IcQc+nLz3KtlnDCUEBu0/NjsCVG5O5XL0wHJxu+pT4/fUe5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWseS4kn4N4+gJwKA1y/KivPMNDWF3wumc0Zx6n/wZIfYQz/I5
	yed9/PPCA6QO2VCKgLSFU+P5y9H9Hfd48jYHjIqQSN6sTTSdqdcUw51pLkwwyPkNAHIu/uVe92N
	Xc39OzNVFWPKg5n/GLDwROhQh5sr5HSkZpXKYE7/rUsUyJIBXrsOdoCJKHxwpiIxAnZ4=
X-Gm-Gg: AfdE7clQCtbR/bnUGtLNKv4Xp0K0nhJMfw5AV6/g6AQV5/HCEeQ3/0ZUSNoMHZiy5lA
	5SC0Xc33PCV2l+mihQiu7lv475wT/S+eh9OanchnYqpRUDsVoSzvWEGFLD3+/pl1MLIeLSs+OVx
	rh26dKBQUVMuOeEaDoFbZEIofPbIVbOgz3VF8W5FDbynev2JlxFfCafeSKR2MflJbUdJ66Z4cu6
	xLQa9OVf2AdCAnuTzDDrMjcJlKrQ1c8Yzxk+A3YoFrDAsmbJVNrK6PMAAqE9EAlHoQBbNpR8JjF
	DlpkVQQFjSzhtahdkl2EHnxOhcBVzlK4wHnp80u8hrtxqW3+lZLCojhkL5UJbSsFJvw+BTkFnAu
	WikzpJOOYzKphd/MWd5ODRR2SavSjVnUx5fSWciibjK+axbwKgYxE6vDFWnMZLQ==
X-Received: by 2002:a05:6102:5126:b0:631:28c1:154e with SMTP id ada2fe7eead31-7246a21458bmr1846910137.16.1781697356321;
        Wed, 17 Jun 2026 04:55:56 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:631:28c1:154e with SMTP id ada2fe7eead31-7246a21458bmr1846803137.16.1781697355338;
        Wed, 17 Jun 2026 04:55:55 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm154442075e9.11.2026.06.17.04.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:55:54 -0700 (PDT)
Message-ID: <e5a9e467-ca1f-4773-97a0-316c0999c751@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 13:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] serial: sb1250-duart: Fix console message
 clobbering at channel resets
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605241620470.1450@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2605241620470.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExMyBTYWx0ZWRfX1+Rfb2YAF8HM
 jC10v7H8M3IW8Wx8k64dhINEk+DvuZEXlvru50dY4csdvePBC/spPa4/xwKaSS7fNEyB5YrDVEo
 w1y3KWYnVjlQALmk+TD8otthY+qPw4U=
X-Proofpoint-ORIG-GUID: OboRqL9eYmAYYTZkap_RgQlThGWmILOr
X-Proofpoint-GUID: OboRqL9eYmAYYTZkap_RgQlThGWmILOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExMyBTYWx0ZWRfXwVziLFJtDbWJ
 /l19y92FT5NJ7flVcGzT+ojHsY/ZE17rc+VyvdLdFaI5gn5iNBbiltaf4zUoOlchCbG67d8lBfl
 6iUxzESsiJXxvMWiPa1fztheant5lMZ9BeHz1OOtrE0+rY2DoxVKlooPOqvyxOy5MVIuOlsxYQH
 EWNsDQpUPsaaC45lP8PVrex0J0JeIr4q/rgzCQZ/B6LzoDZkMMZyUNDJ2BLahbQncKlRj93L83G
 tUvG0QJjacxQAae2pP7Sch+L8FkmnRMkbxGGrqAaqxJu6BQzpMLshdyTtK9zMrwQHRwgsrfhVBg
 12TOr0nrmDL+0Sx5nl51/vRdvoDCoFfpMp6FX15F3hn32oGemID6Q22x/g47UBUjMozp/mMK2Nd
 jqEVRhnCwI0gvIrecIwxo7CZgUHlY8PBFFWwto+4pmrPclqP0reewpSXyggKpyRQWpU/gOFSQk+
 1NlE9UAsErKldTMDwQQ==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a328b4d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=_c3b9wjhhov0UwWOKkwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170113

On 25/5/26 01:12, Maciej W. Rozycki wrote:
> Ensure any characters outstanding have been sent before issuing channel
> resets so as to prevent messages issued to the bootconsole from getting
> clobbered.
> 
> Contrary to device documentation at the time the transmitter empty bit
> is set only the transmit FIFO has been drained and there is still data
> outstanding in the transmitter shift register, so wait an extra amount
> of time for that register to drain too.  This also prevents subsequent
> messages produced to the console from getting clobbered, owing to what
> seems a transmitter synchronisation issue.
> 
> When called from sbd_serial_console_init() it is too early for fsleep()
> to work and even before lpj has been calculated and therefore the delay
> is actually not sufficient for the transmitter to drain and is merely a
> placeholder now.  This will be addressed in a follow-up change.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
> Changes from v1 (1/4),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2604130321540.29980@angie.orcam.me.uk/>:
> 
> - Sanitise the change heading.
> ---
>   drivers/tty/serial/sb1250-duart.c |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
