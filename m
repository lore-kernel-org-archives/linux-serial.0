Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4166EC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ABB60E91
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhGWHRw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:17:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233291AbhGWHRv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:17:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N7p4Bp136247;
        Fri, 23 Jul 2021 03:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jU3lbDQCNS3KkID+IIlXd4vuBp9ztfGLQxPWfLTeI9M=;
 b=InW/xbxegS27e/nes/OcoqDEb+ZsjloOT85379QLgRKNg+OMdkM+JFnuvh8PtPHQWKaC
 fbrOKz90DirS7wMxgtiGA7gbbGJMcxyNteGkqPfDR6/dyzfwbWRAhrzdpOo/8FWKCWzZ
 9CJjFpreorUoEbmEUhS7jVI/zENCeNUeFO/5G86Dr1XH86uO9+ScMS7A8glOfrfD5ktw
 ZC2P2igmGFyZN1hLAU11nfXKgMIsvMObJ2uLActtnMOZXconFEi4ySmw3wqX3zwtzFT4
 H0hdysW0MeDwubJqQCvPI422vT0whAkm0zS0bIPQ6DUKCcC9UFCBGdMzvhUia7vaydaj xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ysr9847w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 03:57:29 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16N7rMd2141844;
        Fri, 23 Jul 2021 03:57:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ysr9844v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 03:57:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N7ldUp026680;
        Fri, 23 Jul 2021 07:57:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng72h5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:57:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16N7sq0i25035154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 07:54:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BC3811C050;
        Fri, 23 Jul 2021 07:57:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6B7411C058;
        Fri, 23 Jul 2021 07:57:21 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.25.128])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 07:57:21 +0000 (GMT)
Subject: Re: [PATCH 4/8] tty: stop using alloc_tty_driver
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20210723074317.32690-1-jslaby@suse.cz>
 <20210723074317.32690-5-jslaby@suse.cz>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <4323b79d-45e1-9a80-66dd-87bdbd16cc27@de.ibm.com>
Date:   Fri, 23 Jul 2021 09:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723074317.32690-5-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h8hOYcA75sj_mtLNu73Iog4d-HG3Gn7Q
X-Proofpoint-ORIG-GUID: aAoK0-mi5yh38cALVviBs2boHbts6Tuc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_03:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=879 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230043
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 23.07.21 09:43, Jiri Slaby wrote:
> alloc_tty_driver was deprecated by tty_alloc_driver in commit
> 7f0bc6a68ed9 (TTY: pass flags to alloc_tty_driver) in 2012.
> 
> I never got into eliminating alloc_tty_driver until now. So we still
> have two functions for allocating drivers which might be confusing. So
> get rid of alloc_tty_driver uses to eliminate it for good in the next
> patch.
> 
> Note we need to switch return value checking as tty_alloc_driver uses
> ERR_PTR. And flags are now a parameter of tty_alloc_driver.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
[..]
>   drivers/s390/char/con3215.c            |  7 +++----
>   drivers/s390/char/sclp_tty.c           |  7 +++----
>   drivers/s390/char/sclp_vt220.c         |  7 +++----

s390 parts look sane

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

