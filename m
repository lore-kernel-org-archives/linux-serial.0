Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81767F9D6
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273093; cv=none; b=CPbpyP62YDT1Fgf2l2RvOalVNtsmrEEexFEUuAvRI7z1ZQaZNPPxS664uKUnVuxOpt2RA3wjgvgQbNduiseU7CgDnHLTNKGIJ7AbYQcHyq7QP9NPfPdJa+4/R4tR7W0577T5jpvnZ20Qpynwv6iJIXcvaI+Dy6kLaJfCYCfCYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273093; c=relaxed/simple;
	bh=0Ua2anGm+Zkes34NxIgO6E5Ea+znSU2PSDX5jTb8nuM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=etO4ei7U2dMp5ZnVj/VvQQCHqL8nGxSYHqHRxGpj5od8W1FWN2aJmU2AAabVASp1Rt1kfILBSCPahpFqPxUrB1gqNm2ZEpH+hrP4VzncX7Sj9fqKhYddHVMti3hbuKtdagHipOmXp6QdnBnxtdIoMf2PJQ4igdNxAtXxgVzZCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LiAiaq4j; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LiAiaq4j"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240207023128epoutp01168461920d843cb14db5b6dcae915033~xc9QPuP0h3140331403epoutp01c
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 02:31:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240207023128epoutp01168461920d843cb14db5b6dcae915033~xc9QPuP0h3140331403epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707273088;
	bh=ANHZv412Dg+fCGbgGPRPJxGYQWRFR9Bp1dtID0lKAec=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LiAiaq4jv3N73TmFQqiDgE7gK4Gfxu1TC+SUxTYV6610yppEq+AiaejZPlsFJdeVn
	 UYa8U/o10Fo43y7SkwAp7Cdo93Xx+AFvkLH7hIcg4WMjwp2A1aLeYc7uk6xt0/obnB
	 1eujtuWswIPkRwewBss3Par10LVpRnE3rkD3Vfq8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240207023127epcas5p2b7db665d4a089b6a041129cf1f3502fe~xc9Pt1IDW2585225852epcas5p2c;
	Wed,  7 Feb 2024 02:31:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TV3yj6kBVz4x9Q3; Wed,  7 Feb
	2024 02:31:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.3F.19369.D7BE2C56; Wed,  7 Feb 2024 11:31:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240206113359epcas5p44b31963a9b932530ff9e2c349a2fe466~xQtpLLOgD2813628136epcas5p49;
	Tue,  6 Feb 2024 11:33:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240206113359epsmtrp245a884d3b2c5a66a072c68f46f4b15c2~xQtpKUHc90849508495epsmtrp2p;
	Tue,  6 Feb 2024 11:33:59 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-f5-65c2eb7da326
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.3B.08755.62912C56; Tue,  6 Feb 2024 20:33:58 +0900 (KST)
Received: from FDSFTE048 (unknown [107.116.189.46]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240206113357epsmtip2e0b997287d5fd76a11945d1b8b8a204c~xQtnzojQK1860618606epsmtip2v;
	Tue,  6 Feb 2024 11:33:57 +0000 (GMT)
From: "Tamseel Shams" <m.shams@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<alim.akhtar@samsung.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
In-Reply-To: <0a2604e7-8b30-4cf9-9099-ba3681bc5538@linaro.org>
Subject: RE: [PATCH v2] serial: samsung: honor fifosize from dts at first
Date: Tue, 6 Feb 2024 17:03:56 +0530
Message-ID: <006b01da58f0$601316b0$20394410$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQGLvBEqWUIU8btMzlwH+Ehg5kjUAwE8LAIjAhrCDkaxf69ZIA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmpm7t60OpBk+PKFo8mLeNzaJ58Xo2
	i3dzZSz6Xjxkttj7eiu7xabH11gtLu+aw2Yx4/w+Joszi3vZHTg9Nq3qZPO4c20Pm8f+uWvY
	PTYvqffo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
	3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWl
	eel6eaklVoYGBkamQIUJ2RmP+pMKZktW/Fz0n7mBcb9IFyMnh4SAicSna+eYuhi5OIQE9jBK
	nF9ykxXC+cQo8eDsUhYI5xujxNoZ3awwLa1b+9khEnsZJU7f7mWDcF4wSqw+vJwFpIpNQFvi
	3a6zYINFBLYxSnx9eQnMYRaYzCjROHk1E0gVp4CdRPOJ18wgtrCAp8TpaX/AdrAIqEj0b54L
	VsMrYCnxf989NghbUOLkzCdgG5gF5CW2v53DDHGTgsTPp8tYIeLiEkd/9oDFRQScJBaefABV
	s5JD4sQCNQjbRWLBkt+MELawxKvjW9ghbCmJz+/2skHY6RJzH/YyQdgFEst2fYeqsZc4cGUO
	0A0cQLs0Jdbv0ocIy0pMPbWOCeIEPone30+gWnkldsyDsRUl/u/uhxojLvFuxRTWCYxKs5B8
	NgvJZ7OQfDMLYdsCRpZVjFKpBcW56anJpgWGunmp5fAoT87P3cQITrRaATsYV2/4q3eIkYmD
	8RCjBAezkgiv2Y4DqUK8KYmVValF+fFFpTmpxYcYTYHhPZFZSjQ5H5jq80riDU0sDUzMzMxM
	LI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYNI72/N/c7iSJ8Myxgf+ATG9SUFFTaV9
	oZbf9rXdKn7kf1elUi7rTyi3vpMHx76kG18sJk6Ktv3l6RH3ib1is//VTYuWJWxd+tNlzZ/V
	v2R4Vxa87inRa5yUqPDRVbRG7IKkXNXDpjVPXy7ervC7Uzahd8PN4zf/POsr/Ms1Wbl+7ZuD
	3z4waS74tiHvzh6ZiqPuNza/X26+xX7J8bn/lqlqH5bqLLTtcbhp+uP6nRXn/34+edfP2nbL
	Y5H480e5pJV6F9240N/QsYdXTSX3xHOO7P89M2sL7kmWK3iu/naqdmbdo9TW9vLimR/mFp9S
	a140/XithMCVNv/XHd5zdD7HPbm1d4Ecp3rxrYber9OUWIozEg21mIuKEwEjnVzCPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK6a5KFUg7VLbCwezNvGZtG8eD2b
	xbu5MhZ9Lx4yW+x9vZXdYtPja6wWl3fNYbOYcX4fk8WZxb3sDpwem1Z1snncubaHzWP/3DXs
	HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxqP+pILZkhU/F/1nbmDcL9LFyMkhIWAi
	0bq1n72LkYtDSGA3o8S+G2eZIBLiEtN+7WeEsIUlVv57DlX0jFHi/aRmFpAEm4C2xLtdIA1c
	HCICuxglZpx+wgriMAtMZZT41fOIGaJlD6NE79mjYLM4Bewkmk+8ZgaxhQU8JU5P+8MKYrMI
	qEj0b54LtptXwFLi/757bBC2oMTJmU/A1jEDret92MoIYctLbH87hxniPgWJn0+XsULExSWO
	/uwBi4sIOEksPPmAeQKj8Cwko2YhGTULyahZSNoXMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
	zUvXS87P3cQIjjYtzR2M21d90DvEyMTBeIhRgoNZSYTXbMeBVCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MlQtEJjIvn6G5PFji3XOPqZvnu94zZbv7
	4PqVOXEz6xxmtqxjWFr37emVDQ+Unp77HsqyYcM2g/mfN+6KmuJ04Eqw9NSVrWk8gY22c4Lu
	8fzpu/T3ZXV56QG7k9e0PSXuHE+4uexx3v2dQdxZlWWvFt9/vCZOM+XikbsyPstbnn+LFmuO
	iZo/oeTeJl6npVEZQhczTDh8nJRFmbmYbmo7FrdfL/q8N6F1Vv6tq9tMjtXomM/661ourrDz
	RMvHTJuDM5aEZf5MffHr5ZVva3eXPVNVDvL4wsc0/4n6lDzBOUlbn8naeBpWZ0wS2XQ3al+I
	4vmHJxlU07QdrATXRjZluus1aFlpFX4RimfddW9JpRJLcUaioRZzUXEiADG1IgolAwAA
X-CMS-MailID: 20240206113359epcas5p44b31963a9b932530ff9e2c349a2fe466
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240205082441epcas5p1e904f4f95852de3fd8663742ed5131df
References: <CGME20240205082441epcas5p1e904f4f95852de3fd8663742ed5131df@epcas5p1.samsung.com>
	<20240205082434.36531-1-m.shams@samsung.com>
	<0a2604e7-8b30-4cf9-9099-ba3681bc5538@linaro.org>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 06 February 2024 15:42
> To: Tamseel Shams <m.shams@samsung.com>; alim.akhtar@samsung.com;
> krzysztof.kozlowski+dt@linaro.org; gregkh@linuxfoundation.org;
> jirislaby@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> serial@vger.kernel.org
> Subject: Re: [PATCH v2] serial: samsung: honor fifosize from dts at first
> 
> On 05/02/2024 09:24, Tamseel Shams wrote:
> > Currently for platforms which passes UART fifosize from DT gets
> > override by local driver structure "s3c24xx_serial_drv_data", which is
> > not intended. Change the code to honor fifosize from device tree at
> > first.
> >
> > Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> > ---
> > Change Log:
> > v1 -> v2:
> > Acknowledged Krzysztof's comments
> > Initialized "ret" variable
> >
> >  drivers/tty/serial/samsung_tty.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 71d17d804fda..e5dc2c32b1bd 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -1952,7 +1952,7 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct s3c24xx_uart_port *ourport;
> >  	int index = probe_index;
> > -	int ret, prop = 0;
> > +	int ret = 1, prop = 0;
> 
> I am sorry, but return of probe function cannot be positive.
> 

Thanks for the review.

I am reusing the "ret" variable to check whether fifosize property
is present in DT or not. It will be overwritten at later stage in probe
function before returning. Also, "ret" variable is used to return from
probe function only in case of failure i.e. "ret" is negative.
Currently, probe function always returns 0 in case of success.

For better readability, I am thinking of introducing a new variable for
checking the return value from function "of_property_read_u32" while
getting "samsung,uart-fifosize" property.

What are your thoughts on that?

> >
> >  	if (np) {
> >  		ret = of_alias_get_id(np, "serial"); @@ -1990,8 +1990,7 @@
> static
> > int s3c24xx_serial_probe(struct platform_device *pdev)
> >  	}
> >
> >  	if (np) {
> > -		of_property_read_u32(np,
> > -			"samsung,uart-fifosize", &ourport->port.fifosize);
> > +		ret = of_property_read_u32(np, "samsung,uart-fifosize",
> > +&ourport->port.fifosize);
> >
> >  		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> >  			switch (prop) {
> > @@ -2009,10 +2008,13 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  		}
> >  	}
> >
> > -	if (ourport->drv_data->fifosize[index])
> > -		ourport->port.fifosize = ourport->drv_data->fifosize[index];
> > -	else if (ourport->info->fifosize)
> > -		ourport->port.fifosize = ourport->info->fifosize;
> > +	if (ret) {
> 
> Are you sure that you are checking correct ret?

Explanation same as above. 


Thanks & Regards,
Tamseel Shams


