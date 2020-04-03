Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF0C2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5C520857
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lqv+7NO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgDCLNB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:13:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:45302 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgDCLNB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 07:13:01 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200403111258epoutp034016b72d0162296c2f27d398e2508979~CSufbdZoM1751517515epoutp03_
        for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2020 11:12:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200403111258epoutp034016b72d0162296c2f27d398e2508979~CSufbdZoM1751517515epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585912378;
        bh=pA8bbH0J0a+qUde69DwBe1rYmqYSp0wwFAR3wM309Vc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Lqv+7NO1rmVAXbBDIVO6yWr3G2WK3h88TYu/fPc54uRluXChWOHyq+kjr6vNtIjM8
         VvHeRz8+2s5LmEiWnWqLkjedZGqCmVDYqFPwmaZldyJ0D8G0BaPYarwZ5wxdKIa9+p
         iSVaMV7Jia/DzQ1Ly725z+yq52xEFkV1DoUhU9aU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200403111258epcas2p3ee44d19a4741efdbb83511769ec5e3fd~CSufFlx-z0608006080epcas2p3O;
        Fri,  3 Apr 2020 11:12:58 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48ty2w5FsvzMqYkY; Fri,  3 Apr
        2020 11:12:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.76.04598.83A178E5; Fri,  3 Apr 2020 20:12:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200403111255epcas2p3f65f59b797653cca215f587b68008dea~CSudEwg8V3171331713epcas2p3u;
        Fri,  3 Apr 2020 11:12:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200403111255epsmtrp19483369847eb24dea5b9edce8874d493~CSudD-Q7j1160411604epsmtrp15;
        Fri,  3 Apr 2020 11:12:55 +0000 (GMT)
X-AuditID: b6c32a45-ea1ff700000011f6-5c-5e871a382f16
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.0E.04024.73A178E5; Fri,  3 Apr 2020 20:12:55 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200403111255epsmtip254b15dded8b30bf3eef4d68f3ccb199a~CSuc2tkOy1567915679epsmtip2O;
        Fri,  3 Apr 2020 11:12:55 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403104744.GA29385@kozik-lap>
Subject: RE: [PATCH v3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Fri, 3 Apr 2020 20:12:55 +0900
Message-ID: <005601d609a8$d3243710$796ca530$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QGozxKaAhmfaBwBVB8GPabhL5wA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXa3ezdrdV2WpxU1rlEqmZs2u4ZG0dsgEatvVupFL5t099Lu
        FlofNKr5gpJRkS3tzV5tOdPQoWWhpgkyP0SWpiGokb2KgZgYdbdr5Lffc875P/9znufIMdUD
        XC3PtThYu4XhKDxE2tQRRcfQ6qIMbf3NSPp0jRenL9ZPSuhzo18wuq+vnqAbRvtl9OuWKpyu
        7GuT0L015cR2uaGhtgQ3PK/2EIbG2wUG75M3UsPPhjVpsnQuycQyOaxdw1qyrTm5FmMyte9g
        5s5MfYJWF6NLpLdQGgtjZpOpXSlpMXtyOaEVSnOc4ZxCKI3heSp2W5Ld6nSwGpOVdyRTrC2H
        s+l0tk08Y+adFuOmbKt5q06rjdMLlVmc6U+hX2brUeVd8lVghej9klKkkAO5GQbOfJQGWEX6
        EFycoEtRiMBTCCqnu3DxMI1goPg3+qdonXklERXPEHwePiIWTSAYHCkPJnAyBl7XjAU5TODG
        d/eIQBFGziBom/bLAgkFGQu3qruCty4jD4CragQPsJRcBz1fvwfjSjIR5vxf5zkUeq6MBXvF
        yLXQ/K0KEzvSwK/xuzLRbA90eoYIsSYMrpa4sIAxkD9wqO0alIqCXXD5WsX8OMvgc/cTQmQ1
        TJxzzXMBtLnOE6K4DMGvyXGZmIgH98ciQSwXHKLA2xIbQCAjoHNwvrclUNzxmxDDSih2qUTh
        eqib/iQReTV4xluICkS5F0zmXjCZe8EE7v9eN5C0Fq1gbbzZyPJxNt3Cz25AwTWN3u1Dlf6U
        dkTKEbVYqQ0vylDJmON8vrkdgRyjwpQ7Ks9mqJQ5TP4J1m7NtDs5lm9HeuHhz2Pq5dlWYekt
        jkydPi4hQZuop/UJcTQVrmxcNHBYRRoZB3uUZW2s/Z9OIleoC1HebPXS56vmmrNoz4bUNHzr
        Sdf9/pU+783Z08ljq5i9sejTxpep4Z5e7MOt9KfGArrvaKS/Nvf6qcejk5eGyy4o8u4sejUX
        39RqkimOjVTtH9Y4+yMyNDXRvdG+0cEXnG/b9zpNQUdR8/DQWy7r0Uh+81SoF40XTzyc/XAo
        vrvkMSXlTYwuGrPzzF9FKthdvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvK65VHucwc8fBhbNi9ezWUzZ8IHJ
        ov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyOLO4l92Bw2PTqk42j/1z17B7bF5S77F+y1UW
        j8+b5AJYo7hsUlJzMstSi/TtErgy/jecYy04KVQxdccE5gbG23xdjJwcEgImErt/nGDqYuTi
        EBLYzShx+sYbRoiEjMSEF0uYIWxhifstR1hBbCGB54wSZzeZg9hsAroSlxc/YQKxRYDszTeW
        s4MMYhb4xyjR/PYOM0TDE0aJU9drQGxOAX2JRXOPgS0QFgiQOHagEayGRUBF4uSbd2BxXgFL
        iT/n3kDZghInZz5hAbGZBbQlnt58CmXLS2x/OwfqOAWJn0+XsUIc4SZxZM0ddogaEYnZnW3M
        ExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwXGlp
        7mC8vCT+EKMAB6MSD+8NkfY4IdbEsuLK3EOMEhzMSiK8jjNa44R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgbDsb4e1eeUbrxPssyfAYlZw0H49znG8u
        6x6qOTBd6PevZ6cnvFjkWH5O+c2uTKa9CirJMR1fv7y5efj6nRrtguA10456++9dbvdhz7Pl
        JaLKEj71hYpMv93YWBJr5s48942VTfoLU8XBC9uUBF19GfzljnLfURH5HLPrwIGqafHsuSsS
        A6fPU2Ipzkg01GIuKk4EAMvMarmnAgAA
X-CMS-MailID: 20200403111255epcas2p3f65f59b797653cca215f587b68008dea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200403102049epcas2p1d1fe95160b7f37609a8b1710c196cdd8@epcas2p1.samsung.com>
        <20200403102041.22015-1-hyunki00.koo@samsung.com>
        <20200403104744.GA29385@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 7:48:38PM +0900, Krzysztof Kozlowski
> On Fri, Apr 03, 2020 at 07:20:41PM +0900, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > ---
> > v3: change rd_regl to rd_reg in line 954 for backward compatibility.
> 
> I cannot find this change against v2.
Okay, I will add all changes.
> 
> > ---
> >
> >  drivers/tty/serial/samsung_tty.c | 76
> > +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 64 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 73f951d65b93..a674a80163ed 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {  #define
> > portaddrl(port, reg) \
> >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> >
> > -#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
> > +static unsigned int rd_reg(struct uart_port *port, int reg)
> 
> You should return here u32 to be consistent with readl_relaxed.
> 
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		return readb_relaxed(portaddr(port, reg));
> > +	case UPIO_MEM32:
> > +		return readl_relaxed(portaddr(port, reg));
> > +	default:
> > +		return 0;
> > +	}
> > +	return 0;
> > +}
> > +
> >  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> >
> > -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port,
> > reg))
> > +static void wr_reg(struct uart_port *port, int reg, int val)
> 
> val should be u32.
Okay, I will apply it.
> 
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		writeb_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	}
> > +}
> > +
> >  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port,
> > reg))
> >
> > +static void write_buf(struct uart_port *port, int reg, int val)
> 
> buf is misleading, you do not write here any buffer. Maybe
> "wr_reg_barrier()" or "wr_reg_order()"?
Okay, wr_reg_barrier  would be good, I will apply it.
> 
> Best regards,
> Krzysztof



