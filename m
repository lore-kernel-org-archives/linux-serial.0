Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77704C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526966147E
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhENRKd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 13:10:33 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:34050 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhENRKc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 13:10:32 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EH4TKU008951;
        Fri, 14 May 2021 17:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=x3X5ykPsGBJC4Fs0o3ag96IXaZivVWj0tI7KuCm3wFY=;
 b=gPeV2VL/qvyKep5W8s8cp6fHdB9X4tW+CdZGSxXtN/I783sb/JvtZLmHp51wkbfV1FNP
 vLZ1zao8mrKMbP/XdLV2Jssb16ArWeWlzQxKGuj8MPkeghuODnliVNd/2qyX4PC/spBF
 FVpsefHzvfN8riX5z7duRJmvTunSUmexxMDYza93l706fpmxLbXMZjtva3BPQdyB1rrr
 9JDkhNAgVgxKGjqUag8WY00KbYk79m75Kp2rn4vyTy9vv17zVKa6nkOpR2Eo/B5qGq5V
 UjX+7L3erqg2qWWLWCfhcVz7F4GIVrC2FBfGD0gLZJ2L2yyv9C/+gWnF9c0pG6yK+1Es /g== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 38hnn03huv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 17:09:16 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 51FA781;
        Fri, 14 May 2021 17:09:15 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.33.237.3])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 89C7839;
        Fri, 14 May 2021 17:09:14 +0000 (UTC)
Date:   Fri, 14 May 2021 11:09:14 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Randy Wright <rwright@hpe.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, geert+renesas@glider.be, u74147@gmail.com,
        tobiasdiedrich@gmail.com, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH] Add support for new HPE serial device
Message-ID: <YJ6uuqggRTJ4DVCW@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1621009614-28836-1-git-send-email-rwright@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621009614-28836-1-git-send-email-rwright@hpe.com>
X-Proofpoint-ORIG-GUID: nL494R9fbgKLZGYVhwLKDdGo24OlZxji
X-Proofpoint-GUID: nL494R9fbgKLZGYVhwLKDdGo24OlZxji
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_07:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140136
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 14, 2021 at 10:26:54AM -0600, Randy Wright wrote:
> Add support for new HPE serial device.  It is MSI enabled,
> but otherwise similar to legacy HP server serial devices.
> 
> Signed-off-by: Randy Wright <rwright@hpe.com>


Tested-by: Jerry Hoemann <jerry.hoemann@hpe.com>


> ---
>  drivers/tty/serial/8250/8250_pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 689d822..04fe424 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -56,6 +56,8 @@ struct serial_private {
>  	int			line[];
>  };
>  
> +#define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
> +
>  static const struct pci_device_id pci_use_msi[] = {
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
>  			 0xA000, 0x1000) },
> @@ -63,6 +65,8 @@ struct serial_private {
>  			 0xA000, 0x1000) },
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
>  			 0xA000, 0x1000) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
> +			 PCI_ANY_ID, PCI_ANY_ID) },
>  	{ }
>  };
>  
> @@ -1998,6 +2002,16 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
>  		.setup		= pci_hp_diva_setup,
>  	},
>  	/*
> +	 * HPE PCI serial device
> +	 */
> +	{
> +		.vendor         = PCI_VENDOR_ID_HP_3PAR,
> +		.device         = PCI_DEVICE_ID_HPE_PCI_SERIAL,
> +		.subvendor      = PCI_ANY_ID,
> +		.subdevice      = PCI_ANY_ID,
> +		.setup		= pci_hp_diva_setup,
> +	},
> +	/*
>  	 * Intel
>  	 */
>  	{
> @@ -4973,6 +4987,10 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
>  	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  		pbn_b2_1_115200 },
> +	/* HPE PCI serial device */
> +	{	PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_b1_1_115200 },
>  
>  	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM2,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -- 
> 1.8.3.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
