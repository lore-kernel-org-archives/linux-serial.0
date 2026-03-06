Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3937C106
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792889; cv=pass; b=Kup0VNsnOBdZUMpfvydIysDKEcGHGfaRQU53ErQMlHVQTX6Ioy7I6KB7sDHOUdS0ugPXls+DmDoIw6FLpM2BFcfmaooV1VbkYE5emzkyqEng3TfH9JwApOM02J/lEGAunVDqZMYHURwB0uwVd1mit8P4PikF26ZI9dbqaKNEsA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792889; c=relaxed/simple;
	bh=tdvWNHoSdu2Iafp7/mrEBG/G+46fyd5oPjPg3sfvUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCtd5ujnQ41Ow8Sel+UpOzxnIIKs7tFKAdtrURdRt2GyFUu6JSKh78WL7kjTPIPaOECMtk/D9Hk84brfKtF+xUiwzOcYZqUcCaPgeE73q07uTT5DxO/sXJwMx3UqDyfc6fVBU9Mdv/w7cJtYG7KkHSON0fn4n2zcuqyt43ftHe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZNrFYMs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwivZVDt; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZNrFYMs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwivZVDt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6269OrHd3429544
	for <linux-serial@vger.kernel.org>; Fri, 6 Mar 2026 10:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=; b=YZNrFYMsk/Fkkusp
	mx2tkNw7vXOuadXBQCGBDBUTlnpr4NZWNentC4QFbcG5JFgpAt1ePFONSVn3deL1
	du6XPuHnmNjRjKozn+7yp1KVO4GZaLcJhVStbKqzhRv6jX3CKxlmllys+4Hzatey
	JliSi8fTmWxnYIg9oOT7O3uCq0cv5Jri9G5kxjq3+xcNYylT8JoAnL+RjcsKgw16
	/Run8SLGv4x8IrgXOw/d+NvubpqD7qO6zmjgcukTczcfqrv9Zw8Q9k2STjZkcRnt
	HWfPzwo+IOH3e4ul5BaL3HOs5xN+3QhnD3tMo+cIdjqsEqso8ZuPjOWrhJrKndmA
	3Yz0vw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv98g6qr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2026 10:28:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4a241582so4629963485a.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2026 02:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772792885; cv=none;
        d=google.com; s=arc-20240605;
        b=Bwl2X79IhFQJbLV2NEwOumgWUQQOsqf8igB08EY4HtfXhyU05B/IeXLH8XlZ/h/CsP
         z6NfEH3yYkuiD8AIjTa5JrqR2Acd8TYBrld4E8faSdD/NEQpZQt79UG3jaJm4UYla5XZ
         u+dANTTkCUofvVNJdeGTBwb/uTIGFUSSMAVqIHtIw9YPvf/gv0PXsZteHRi030r+RfEo
         0ru/ZutG+GGw5qssistGzFV5hkFtA51xYYVrcEyphLi5CYZnauj8lxpLnEx0RMpO/hr1
         sFhnDHYJIDDFcmQW9PhA4Otz9jDa+xN3jZys7FT5m/L6LfLOLCOzT0oY8O2rwBBiQfkS
         DS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        fh=xnFAkOwLVYsT3BIzGNVlqF7t0i7aEVtAYTN4+vCSmO0=;
        b=TrjJhKAXbaB6BTRhnTmzyLbvZRzCHQ2QaQqRVZRNHNWjrcezZIRn/yCr2S8HYUvPjI
         rbgdWUaSTvr0r3D9v8rHrWbUM/SaALLeAqC7V5aC0l8rR4TARcaBC935LTiVWXc01klU
         EskiinaxjdsYcz7KdhGOyE8oFVcgM0cdhKfHgPCWtDS1mffRFfYhXrXqS8jX2Ex8iMO8
         4fDl+9XEV6s5Ts4j4yte5ItuDL1DLEY9Dq3tzERyOl+PCUOv1SAVeOL5nfmOahuZDn5G
         TzkstfIN6yKoZLZ5ktQXOHMNze2ke2XcCs9QN+4POwOl/HmI5HHLRNNEt/NiaArhifuG
         Rncg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772792885; x=1773397685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=ZwivZVDtbsWU/w8SoRcOCkZQ17h+GAfpi7mAEOZrgCFR7mbSQXetIjRIpWcXZbcQXx
         AqH8KHNfiBH4FMALrRqOmI3gWXZIN1vZ6+9l8vpknH0Q45kEsncxQLswJ/qFThba8KwS
         o4XR9GnnvcJXasjT7v+cns/MJm8hTIZLvxu3pkzAYBgbSFmEyqjFWg89kBcPI8wSQjcw
         y3qEJE7lhg4LSNoQikIklx9FQm6ZiFYC7uh++TAvpVlXFTZ3wS0MTp/goLD/o1fKisjF
         QSTWArRoSpBGU3SPHzwmBxD1TQUUyIAM1CHO+JQ4rMrViyx2D35JgAKYcO/LModEJGo3
         yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792885; x=1773397685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=ePzUxWg7BIaj0Vtz73TKnzG/9fCN9mGQ4vx56suZ9a3boo4DMNEncvdABObr0YD6kd
         +r95+WiOWmwQEmLjm12ueW96NI/me4yh0RqqOeeFQYadi4Sev093HzLBkmSj0XokRuFL
         iokMyaxkR1ywLQqeqldq6xdE4BW1RL6pPzFGGaqD2nnJXLYx7SYG/XFBc0Qa83BGcVaV
         WwYwFX8WzbYKrHlZXSm138M7aI1n7G4WM7UzyH3c32Ylb5ecE8oAhB1xJgljEmntqpaD
         MN5oqcad3cE+ppF+eHEqyAIp/ZKNqR4/LYZ7hvZMXyk5QkWs89ORqAInT+zntuPae4s8
         W9rA==
X-Forwarded-Encrypted: i=1; AJvYcCUSvFqGs2R5OT4ZTy1Nbn7NU4cEoD4dmTup8WTCF7U0XGkSmeqwf2YCMqoNo8ytOyzHsVaDJNhydHTmxFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdU7x28MI5nOj6i8S4V0dVS7flEnDHpO/50h8do6m8wKUQ/Ib8
	llqGsqRcJRcJDpkzW5BcayV0m28ZFACcUb0r5k4NZHaERKLIMSQff0PWaw5jUoBqqZi2rl4q9R7
	dzO8TEH/qKETHpjWLxEoQLqe+o/GIIL0aTRIwj95qXoQf9hHG2qnPPIzCg8mtTSRh+t7Jf6u4aF
	gQDbAicUc0O6UGNYab9ZymjZbH8ZcAS3uCnG2VYptFR4adM8KAl9Bk9R8=
X-Gm-Gg: ATEYQzxmjSY+JfnJ8urnsLe4a5MjUKjcb3dkeZkJGH11PA2TGVlSxGKExCtM/Efl2I7
	92p4/XzXe2FWtXu472Rrh1eGTiS8Ew1352wQWnLgVhSHQzZi/mfJMccIiVwwgLwLkDJxz4lSzu+
	J+iWp5qCgVa95WwvB/4B6n0HFiDc43ey/wGow7+537ZIUqKikNdGJh8WpffeLM1mbig36gbNPnB
	1EBkVRC/ORhCDBgH3EPV+K/1SoM6DrV8QKo3hc=
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr161743485a.78.1772792885465;
        Fri, 06 Mar 2026 02:28:05 -0800 (PST)
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id
 af79cd13be357-8cd6d4afe58mr161739885a.78.1772792884906; Fri, 06 Mar 2026
 02:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com> <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 11:27:53 +0100
X-Gm-Features: AaiRm53iYOytG8xnHxV8VVUSUeAKgAc5EavTdm2RyqP-mIqV3qUo5jYkbTQaMc4
Message-ID: <CAFEp6-02wcaEYr5BJvqMgtMD6vArLghvw+Lh-YE+OLXyZa-i6Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Zy2JjBY8tno2goQGRNyKVjpxtIRP3cXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX0tHdK0wkh3Es
 gSaCapagZoCNPnDAFKylahisolzC7btZZo5V1UCW7Utc37ocaOru8pEwIp7no0Qk4Z8Y8fYJd99
 8f7YGg7pyoZ3jRsi3lcq1K7/Tk9hISikJSdyU0M8Wy+fCuUmfmAJP+1PMCKmUiIZZk6cUR+8PmK
 GUEZsfw9mKjgdOMedRU/EGNEDWxPvH2UpwbXd/FRu3YOjpuTUsONG+Q32UlV1E6LDOJ7yuyLe4Z
 iJD9qCE6G86mrFAqlZV/NSQgI9U8KZT1DF3wIawSgUrxFAykfFHmewoARRHtqIdPbLRFvagP7Os
 Ra4z4owKTXffcWJFKA5CMhP7RQiAaB1K4ukuSH6toH3z4HjodFmlz6RYYHqpuIHNAHJ+OxYDz46
 AX5cFh0XAqw9X/dS+0TO5AT4Ne4zoYAqAxt4on6/zwus6rbZwLS6x1l9n48sndBarbTiPbbvILG
 1F7mlTxizEu1mNKBEkw==
X-Authority-Analysis: v=2.4 cv=LbcxKzfi c=1 sm=1 tr=0 ts=69aaac36 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Aq5ih5MREXdaAn1MBKMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Zy2JjBY8tno2goQGRNyKVjpxtIRP3cXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

On Tue, Feb 24, 2026 at 6:32=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector define=
d
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card=
,
> but that is not covered in this binding.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating a=
t
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fin=
e
> grained power management.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14=
s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 184 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 185 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.=
yaml
> new file mode 100644
> index 000000000000..82dfd776d480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yam=
l
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical =
Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the h=
ost
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: I2C interface
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.

Just a small nit: according to the spec, W_DISABLE1# is intended for Wi=E2=
=80=91Fi,
while W_DISABLE2# is designated for Bluetooth (Key E).

Regards,
Loic
