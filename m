Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428936CDFD
	for <linux-serial@vger.kernel.org>; Fri, 23 Jan 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152427; cv=none; b=RV4HR0AU39kh5SD3rcnlr2vrboqB4BkSUDDUumpOemzKCZwekStG49QoCLfofQcLrDaR4rprRIknWWxpk10w7MryMvOWCEK7FuIeswQMBF9okJHBO0gqL7tKALstg3zD8XoiFhpQpQ+G4PQ58STZ6gQy6hTLHWsmvFzxj75/HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152427; c=relaxed/simple;
	bh=rirq/fOyMlM31CQl5MqLEiMKur9U+NTbshL35rfFF8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g14hy7boknzaLlO9V1Ga+Uez6aDQ2aJaVF6Y8RIxB5DZQKBat0cAv+wD37wT/l1DfQstpBu+2RxuayG1PXGhKA16DAnd7mP7loOwo1/U39Qk21+fq+ejnOFfEqb3a5hUbGPnwWfj28ucgmev+99goTppa2dc/FSz0XoK5LUbb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCZU+8dG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWh3Hp8g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCZU+8dG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWh3Hp8g"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6Ll2Z324234
	for <linux-serial@vger.kernel.org>; Fri, 23 Jan 2026 07:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=; b=BCZU+8dG8r+EKBwc
	/kBrl+W81aM8cOR30s0OiL5zcTeWxyNv8ZJHlYtYbYx+IjXIsaZyOQwKETCjpkjL
	Lwt+8UvvbjkbqkxS/Y/1DOzvxM35QstAgNCvwdvF0uVqQk0vCavLrNSYXD92ySU4
	Ft2dw5MlOzL9WHUx1BtV8Z0G1B6eFeho9dWeX2sSgEwQ8akpQteuxwFd542bfW6C
	IIXS31wx4EGRqwkrdbysNWh3Ytx338hq4GFZCeNpXnWlN8CkSxscCf5gDPqzYAWq
	vjy/vTHV/p4XDlTSCBQBr5bWT07P/xT5R5k4HuT3nUqrnEhxXTygYGN+mdsDkWrl
	qd01og==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv3mq851b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 23 Jan 2026 07:13:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52c921886so216252885a.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152412; x=1769757212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=;
        b=fWh3Hp8gOqB7/6behUSts/8PR4Wel+zYxiMwYPyAhamug7DtPg2moOFfvMlV92ghfo
         CG25SbdOPB2WubMNDrXTK7JLGN1UdeD8LOSADWxKSY2//Hs0H116lhmtOfXPyuAZYh/0
         I7IBpmIZaYUY1lf20fcD1xRYWSgiNgbTnnPlqKw9Hs3JUFD4ckNNr//aNCMMPDYtKUyb
         OrIEdT1PSZh6PU4OoLLfksF7cE4dHoMNiayUCO5g/v8q/M2CoeJNU6Pwmu1qiwRoS/K0
         raN7nE/4pyGao9ibxkbZjPvjocX/0noD9+22af4WOupN9d5b8rhTy9CYQEsk6mYDgqnB
         c9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152412; x=1769757212;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VcAW3BGRWNZq3yJ8vwvFENkBnsjiKdzsu71g/tYccA=;
        b=CLmQrKyIcZNcIItU9XAEB/+0F1rW8V6auVnZKnR7PYgJUaFw+knFNEIs36Awxsb21B
         jJb1HlDmwoA4F9U+wrwfjyB7Qh2yMxGtS3AmFq+ELxC9/4lF5TWSJ/tR582MLxrZZvQ3
         Vi3KifJDcYPNY44QKiy7ARf9fbFLn8hBzngsg6mFRVv1C5kD1V7s1Uw2xP0can6d7B4l
         d6OIGc+aGVfgAR6H9R3Pk3axWzIWHgpvNmQSraS8/JL3HGHA8qgnBQZKkWwFR2SxO3IJ
         zqARYgpmJw2mAqRPiWfzy7v71VOw7XdXGfM5Dg5nAQEHF+s5ltmMxmvaQbu8c9Xri6f/
         s0UA==
X-Forwarded-Encrypted: i=1; AJvYcCXWAsy1nWEpHO2r3ZlnJFiovkl/t12hCMfSprNjsFjU7RxKPcmVoIJ/JY00jb9+IX9N3t3hno7q2J4Nhz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1frnmjrGQMGoUpH7kjpmy74q9/udYuXdzB2LfF1IdXrT8/a8u
	cWJCy/BDT33rDuweFepo38ovITtF2omLy4Nr0QTB+ttVYCFriJ2R2QZ8kqTDDqJG9C3D+E1WpY+
	mghk8qIajKf9JXbkd6BHypHyA3p9MkkSdd4oveIgWVt0f0gghATjNb5SQoXEfIBEr1AMnrUeCpM
	s=
X-Gm-Gg: AZuq6aIiu11E4vPCgjJXdjgcWhaPkTc5Rzv6qMXbgg+RQuKwo24znUYTrvYrY2yzLO8
	2IwuSglfAUf8+MYb17jK++woQKLvLtVWw4DMB9+GLgWkT5Q4ywNgilJI5LfdsWmSDSAUnBc3MfS
	TkWeE4hRgYosQkGMfmw6YFTmb1HvluwMyafcrUxNDU6q66kHiCs6DqIL1BEwcYJ4X9gI/espvnw
	Dk9egflU2qJNQCoa9tflb7wU2R+D2fePRoIFkgAx72BzgMjw9tm3SxwOTJAvTuqqwcC98ixby5C
	qS3HJpWveu8OM1cI6bO+g7hU3vV9S+XCNvV/Ee+YzPz5vTqgvOXoj5O9ImRuFogbIxhLnZkk6Ux
	7yZf1/oDW72vAGTiYFHBHk9f8dErT0w+wJEXWWQ==
X-Received: by 2002:a05:620a:25d4:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c6e2e3f84bmr234845785a.69.1769152412459;
        Thu, 22 Jan 2026 23:13:32 -0800 (PST)
X-Received: by 2002:a05:620a:25d4:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c6e2e3f84bmr234844585a.69.1769152412000;
        Thu, 22 Jan 2026 23:13:32 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b41asm4471433f8f.39.2026.01.22.23.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 23:13:31 -0800 (PST)
Message-ID: <b02ce9bb-721c-46cd-9f2d-79d38be0ab4f@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 08:13:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Fix not set tty->port race condition
To: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
 <e0ee73fe-2b9e-4976-9648-35a6822b8ad1@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <e0ee73fe-2b9e-4976-9648-35a6822b8ad1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pskmzx3H_fM8nYYmYJ1DPc_UqYbknPA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfX5ElGnXZvrPjz
 p84HC8k2SL/tolLQ9B0rl2eBErDmqQNHfrFg/3ABskEmVQ2TqS7i6uOPJLnsSoCBAlwctZrSy9q
 JhVJHAD0FF44BV/9b2KrqOkPBQOLbrQlotVtyzY9cWZrBcMsfHB9dEkjrqzpvkH578kY519SZOY
 R8ca3lqIz8XKk957IBD0yQ60ZL5Yzly1FfnpnRi3hRi/Cpq/W+tVBoGE2SvbCGd3+i84Gk6uw1t
 +uY8ulUBlAdt+wkkKtaSQvbrpRg16HlFRYon7/USxyodoUnvehxLCiLrEWOOTnqJU09TGHEEhP8
 ClaSbI6XSrJslsXgGuXwJKzciLi/+sncUEBxy3LXkuvzCpXE2ma9fgFMBcyj8klii74rToJZnwt
 kw8bj2ttsyVfuyb6gsAjT7TxR14sb/lMj+YpEdQHXo+P938vR75PABTsVdb9QrCAQKKwoqyaeIC
 wybVynUw6q1ARNWWgWg==
X-Authority-Analysis: v=2.4 cv=SMpPlevH c=1 sm=1 tr=0 ts=69731f9d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uvOF9WSbueI31WoPFvgA:9 a=QEXdDO2ut3YA:10
 a=UzISIztuOb4A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: pskmzx3H_fM8nYYmYJ1DPc_UqYbknPA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230054

On 23/01/2026 06:55, Jiri Slaby wrote:
> On 22. 01. 26, 18:00, Krzysztof Kozlowski wrote:
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 0534b2eb1682..116f33f0643f 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3077,6 +3077,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>>   	if (uport->cons && uport->dev)
>>   		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
>>   
>> +	tty_port_link_device(port, drv->tty_driver, uport->line);
> 
> Bah, so add a comment or I (or somebody) remove it again eventually :(.
> 

Good point.

Best regards,
Krzysztof
