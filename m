Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7AC48BDF
	for <linux-serial@archiver.kernel.org>; Sun, 20 Jun 2021 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8F2611B0
	for <linux-serial@archiver.kernel.org>; Sun, 20 Jun 2021 14:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhFTOy1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Jun 2021 10:54:27 -0400
Received: from mail-eopbgr1310058.outbound.protection.outlook.com ([40.107.131.58]:20512
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhFTOy1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Jun 2021 10:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdDaOlDjGgrqaiaNfTectlustiq84RqLdbi8MUNYBaYtS9fXsF//1fuaRFgWffaw7tRHNfdK0fMqDrtXkcYd+yeQy6y7uoW3ynKw6qAueeiMOoblM+FFLdLnWPKPK4t2k11vSN2jkHeZ73+tnE1PCS/0V/JPkqKr0d4LgFvAnxcKtLMaZkX1wkcXZZ8i1RNp8hTPj5q8V4fqw3RUsvFrBxkGArdNOzvL97Jh62JsdVehnxT7U4LrIk9+lpkK3sE9mKFeAc4yG6cyRLsaFW7jbmJAqI6OIVCE2uJAZyGoUmmDLARR0HGc9F35/UIzQGgJGHKTMXiBms0Bc3Tix5xuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGUQKASVBSstZ/sZZy2FYqLfd9LqXPG1vlpPu37E/cs=;
 b=mfk7ljyMG+BcJucJInpc7UqOl2aswcODt8AMyiW9ot6PedzABp1tGGkWMxPafrSX/GDwGrImXw2R1W2CkdmeiZtnNj8bFXYEghdvTx1hN5gJyUVdXiSiJDaF4nEYq7jdxRDb4+cP0Jld3AUbxN8vStXmH+nsmulC9yhxANoLusBgIc+E5Sk29NVBMcbDC2LBr/YlgJjM/ek9qsGgsh7tDJ9TKtWl2FWdJk1T6fMjP8U5cnEAGd83T+g1OdZ9ndnF/sKA5fJZB+B3t6N9ZHKIf2KzTKWsuk2laCVOq6ls/3bd2LxSGmAFiVmmF8KCnbjdP+cWzoOBm1UO8bckmW3UgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGUQKASVBSstZ/sZZy2FYqLfd9LqXPG1vlpPu37E/cs=;
 b=dg9qrp9CN6hNiwwxdAXKI8kDhBzfMj3OFhuVl7JxHJ+yTJLX8aMsfDhuunGoIaFykM1+y3rCsti0xDxAjpibJtcwJBTggOHh/r8CQwsIYV8I500MXpwnV2rmVSFQSFj+Fd3LOX+tdz6dgJ4yR1kh08G9gUqrJz2f2qbwRu/y6dA=
Received: from HK0PR01MB2499.apcprd01.prod.exchangelabs.com
 (2603:1096:203:7c::9) by HK0PR01MB2593.apcprd01.prod.exchangelabs.com
 (2603:1096:203:99::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sun, 20 Jun
 2021 14:52:11 +0000
Received: from HK0PR01MB2499.apcprd01.prod.exchangelabs.com
 ([fe80::9e5:8549:d4af:5fe0]) by HK0PR01MB2499.apcprd01.prod.exchangelabs.com
 ([fe80::9e5:8549:d4af:5fe0%5]) with mapi id 15.20.4242.023; Sun, 20 Jun 2021
 14:52:11 +0000
From:   Jason Li <jason.li@cortina-access.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Subject: RE: [tty:tty-testing 218/218]
 drivers/tty/serial/serial_cortina-access.c:469:6: warning: no previous
 prototype for 'cortina_console_write'
Thread-Topic: [tty:tty-testing 218/218]
 drivers/tty/serial/serial_cortina-access.c:469:6: warning: no previous
 prototype for 'cortina_console_write'
Thread-Index: AQHXZFZwJfiV4jcgWUuMUKd2IxjNBKsc/h+w
Date:   Sun, 20 Jun 2021 14:52:10 +0000
Message-ID: <HK0PR01MB2499A2741A76C6610A20773CA20B9@HK0PR01MB2499.apcprd01.prod.exchangelabs.com>
References: <202106182351.TACYSsac-lkp@intel.com>
In-Reply-To: <202106182351.TACYSsac-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [124.12.89.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c49c39d-fe3f-44d1-9f3f-08d933fafbfe
x-ms-traffictypediagnostic: HK0PR01MB2593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR01MB2593F7CE19C0ED5EBD27794EA20B9@HK0PR01MB2593.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:17;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbZaeFRYHJT1KIjG2Wri6RzFMute0CBPgnWCJWVCHUe8fEYySXBEtJtttolXCmQbdfsI1xCmjsH1OGMJtpMYN+s8GpQhym/tBxdFofuIQ6yrQicUjoZAGEk5QXrC3RtRRZHHHp3d1eRvc7rHyNG2wflT7GKeLcfGCShy5ZrkuqZMawsY3s6H6xWVzcbhPamcks26zC3pbGlbAQqUomSW7R/9nQNsW9xMiUzAbfzobC+XoXqYrAaHGrji2pTdpZmMSMGWoDCei7ONA0H3DLR2aPQuXyBuLAxSiw55ynSVw/2PooravQWQ3hCXhekcM+XxtMwvQLO5KGNWRdqMSLb/A1wKnKuGTTOxsTlpFvabvJOpnnnpATxTDJR3baaOyvFohw6TtPONzehpx3iMIJMIa9ZtIPRI7Sbzo/i6BXTqd1FeaA8cBFhfzGigQFuDvHn89NVxfOqrdBfzN54YW+IOg1UuCoavQnEBOEsRkZHgMkuCUbtCDNpJb9eU42d6ZqHbrfYAytedMKXhRJapeThUcgSVseOrBsZD9gofcLCmjFP1FmGTnwsNnGGbtnt7Tx4072ar0PR5h9hO/70XGLaQ5h5ZNPMK6ZeIe8F270AfBTK79EjJ5+nhCv8JHmb5URPaOlSCGpBqDtqPhO8eB7RxzUR2Fjo3U7oY/S+3Uu2NvNLbKEX0FlD/RYQqTSgJxhsv2ssE80fGXeh6qhTFdkgb+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR01MB2499.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39830400003)(376002)(346002)(396003)(54906003)(55016002)(9686003)(316002)(6506007)(33656002)(66446008)(66556008)(66616009)(64756008)(7696005)(66946007)(53546011)(6916009)(2906002)(66476007)(52536014)(76116006)(4326008)(83380400001)(44832011)(107886003)(122000001)(38100700002)(186003)(86362001)(966005)(478600001)(8936002)(99936003)(26005)(71200400001)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QA/wTCkeziLlBn6P2NTML+gmMPU7ZAmvDU/49wNsgZ5VWiAhirZLlCgagBa?=
 =?us-ascii?Q?VR9PKoQ9giHhPK/I6fzYgcNON06odPiGqNBZFhJEBL04m61aw5ijC9TZAKeo?=
 =?us-ascii?Q?lFqQpIiAl8fZKT3iRwU7zUh3JkNI21+yyyfEjWsDrm6VA6EVSEaKYwg9elq7?=
 =?us-ascii?Q?u9wK7FdtWoTB8cDaAVfwONhq9ZdUH+nKxinG+EbdBPbYEiorjuc8CQ8TQirY?=
 =?us-ascii?Q?5NRUu5NplhDT0URzMoreRfHGP8EJriPwAQDD+yfC2iZLLLVSi9SZTu+1Ga+K?=
 =?us-ascii?Q?uQEiW6n2DY/Vt9rY39PpxCGA/xtV7E8mYmWWoJpmZdO7rfedusqZpsCB4AUk?=
 =?us-ascii?Q?Pyl8wEMJ6z142QDuH6uBBc5ErPFMQTk21zVGN1BMQ7u9vSjWCg4uaNO6itB5?=
 =?us-ascii?Q?lHkWM2dxaOFilsS8+nUt1VaCPYnlO5hdlJYcY744n46hY/LCUvt0tzWqpKFL?=
 =?us-ascii?Q?2TtXeOpOS1nxi35DSjSaotPF8LyCdRHUNiGq9+M0GEv1wq3QKv/8In8u8QEp?=
 =?us-ascii?Q?5S1jVzx1a0VMEtvxt95hWaev5Kjx/PEkSW1NSAaj+qJCtTsG0P+/CDPwLm1h?=
 =?us-ascii?Q?HBDmYZqRr/bnAqig6wRoe53zh6RImhyO+ULcX1bXbnHv/KUSzRmI7CCzjIqB?=
 =?us-ascii?Q?nyc3wMssOl5i1GvRNXX6BhAkYxbG55/+G4Oy145uph9vMBuiMOJm86q3nxcv?=
 =?us-ascii?Q?Es6a6I37AbQVTCSBVZKxjebCMfg+8GT9ZMdjaTkzqlTWiVa3dWA3QtlE739s?=
 =?us-ascii?Q?UGgY65hfWXwvCU+vk+VOknu9JWuafMN0Mku6XPoUbGt3kSUB2bvaXKtiW5iI?=
 =?us-ascii?Q?1qYfeGOGBRwDGqh2JWWOO5tK4Nd54Zzef9aLYFMtR576rgLm+7YYjG/+8Sxt?=
 =?us-ascii?Q?hnf7qlG7yoIJWxKl7tiGjcIa9hozVa3pzsnxnvuByHLNXKckIZWtRuqEBmr6?=
 =?us-ascii?Q?H0+j2L0MtVzD3DCNnpn6cWcipa4SqNoHcnIbLzu2/0S2kb4pCYkGEqBoI8E8?=
 =?us-ascii?Q?kctZwjNG/6m/7YJKiFwb1sENHp7J2F4fbsxFh8x8KliEb/HYCNPOcFUpXans?=
 =?us-ascii?Q?Tt/RfYfP8r2E/4DkTnfalu7GG0P3jwfh5TD48i4oYUEtOt7BNQ19MHBs8MRA?=
 =?us-ascii?Q?KsdjRcJ/dVcV8AFulAKnzkfmno+8Cr+dPw+CAQtUJnKurHRW61q9XQsJeGhS?=
 =?us-ascii?Q?4+JIxl0CicZXP/h4SB9lahU/7yF7ASh/ZbLPxGp4olAHJljiYd2MMMUc5EWg?=
 =?us-ascii?Q?xfi4wDVVJuVzc5eQmrbu8uWFNn/mioJp1dEIViLdClk9jDxgyKri1KJBW792?=
 =?us-ascii?Q?CQY=3D?=
Content-Type: multipart/mixed;
        boundary="_002_HK0PR01MB2499A2741A76C6610A20773CA20B9HK0PR01MB2499apcp_"
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2499.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c49c39d-fe3f-44d1-9f3f-08d933fafbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2021 14:52:11.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3m6mfSj4oEKe2R1y8wz3Towj6qYxgWtOw+QRALvqRtLAFwTfZzDwPtfMiuxdTTDCPDdIGKV4/7qRevNRJYgmL9kRzNMdLIvtqQ8zyWBdw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2593
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--_002_HK0PR01MB2499A2741A76C6610A20773CA20B9HK0PR01MB2499apcp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Greg,
	I just fixed compile warning but fail to push to remote REPO:
	fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/g=
regkh/tty.git/': The requested URL returned error: 403

	So I attach patch for you review.

Sincerely,
Jason

-----Original Message-----
From: kernel test robot <lkp@intel.com>=20
Sent: Friday, June 18, 2021 11:27 PM
To: Jason Li <jason.li@cortina-access.com>
Cc: kbuild-all@lists.01.org; linux-serial@vger.kernel.org; Greg Kroah-Hartm=
an <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 218/218] drivers/tty/serial/serial_cortina-access=
.c:469:6: warning: no previous prototype for 'cortina_console_write'

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-=
testing
head:   b61c8bf4694b5115766849378dcb8787ff54e65e
commit: b61c8bf4694b5115766849378dcb8787ff54e65e [218/218] tty: serial: Add=
 UART driver for Cortina-Access platform
config: m68k-allyesconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/co=
mmit/?id=3Db61c8bf4694b5115766849378dcb8787ff54e65e
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/=
gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout b61c8bf4694b5115766849378dcb8787ff54e65e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cross =
ARCH=3Dm68k=20

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/serial_cortina-access.c:76:27: warning: no previous p=
rototype for 'cortina_uart_get_port' [-Wmissing-prototypes]
      76 | struct cortina_uart_port *cortina_uart_get_port(unsigned int ind=
ex)
         |                           ^~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/serial_cortina-access.c:469:6: warning: no=20
>> previous prototype for 'cortina_console_write' [-Wmissing-prototypes]
     469 | void cortina_console_write(struct console *co, const char *s,
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/cortina_console_write +469 drivers/tty/serial/serial_cortina-access.c

   467=09
   468	#ifdef CONFIG_SERIAL_CORTINA_ACCESS_CONSOLE
 > 469	void cortina_console_write(struct console *co, const char *s,
   470				   unsigned int count)
   471	{
   472		struct uart_port *port;
   473		struct cortina_uart_port *pca_port;
   474		unsigned int i, previous;
   475		unsigned long flags;
   476		int locked;
   477=09
   478		pca_port =3D cortina_uart_get_port(co->index);
   479		port =3D &pca_port->uart;
   480=09
   481		local_irq_save(flags);
   482		if (port->sysrq) {
   483			locked =3D 0;
   484		} else if (oops_in_progress) {
   485			locked =3D spin_trylock(&port->lock);
   486		} else {
   487			spin_lock(&port->lock);
   488			locked =3D 1;
   489		}
   490=09
   491		/* Save current state */
   492		previous =3D readl(port->membase + IE);
   493		/* Disable Tx interrupts so this all goes out in one go */
   494		cortina_uart_stop_tx(port);
   495=09
   496		/* Write all the chars */
   497		for (i =3D 0; i < count; i++) {
   498			/* Wait the TX buffer to be empty, which can't take forever */
   499			while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
   500				cpu_relax();
   501=09
   502			/* Send the char */
   503			writel(*s, port->membase + TX_DAT);
   504=09
   505			/* CR/LF stuff */
   506			if (*s++ =3D=3D '\n') {
   507				/* Wait the TX buffer to be empty */
   508				while (!(readl(port->membase + INFO) & INFO_TX_EMPTY))
   509					cpu_relax();
   510				writel('\r', port->membase + TX_DAT);
   511			}
   512		}
   513=09
   514		writel(previous, port->membase + IE);	/* Put it all back */
   515=09
   516		if (locked)
   517			spin_unlock(&port->lock);
   518		local_irq_restore(flags);
   519	}
   520=09

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org

--_002_HK0PR01MB2499A2741A76C6610A20773CA20B9HK0PR01MB2499apcp_
Content-Type: application/octet-stream;
	name="0001-CA_UART-Fix-compile-warning-in-new-GCC-toolchain.patch"
Content-Description:
 0001-CA_UART-Fix-compile-warning-in-new-GCC-toolchain.patch
Content-Disposition: attachment;
	filename="0001-CA_UART-Fix-compile-warning-in-new-GCC-toolchain.patch";
	size=1236; creation-date="Sun, 20 Jun 2021 14:49:00 GMT";
	modification-date="Sun, 20 Jun 2021 14:49:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNmNhNDFjODkwMjljMjVjNzE3NzQxZDRlZDU5MmE3NThlMWE2OGNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBMaSA8amFzb24ubGlAY29ydGluYS1hY2Nlc3MuY29t
PgpEYXRlOiBTYXQsIDE5IEp1biAyMDIxIDExOjEwOjM0ICswODAwClN1YmplY3Q6IFtQQVRDSF0g
Q0FfVUFSVDogRml4IGNvbXBpbGUgd2FybmluZyBpbiBuZXcgR0NDIHRvb2xjaGFpbi4KCjEuIERl
Y2xhcmUgcHJvdG90eXBlIG9mIGNvcnRpbmFfdWFydF9nZXRfcG9ydCgpCjIuIERlY2xhcmUgcHJv
dG90eXBlIG9mIGNvcnRpbmFfY29uc29sZV93cml0ZSgpCgpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBM
aSA8amFzb24ubGlAY29ydGluYS1hY2Nlc3MuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29ydGluYS1hY2Nlc3MuYyB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L3NlcmlhbF9jb3J0aW5hLWFjY2Vzcy5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3J0
aW5hLWFjY2Vzcy5jCmluZGV4IGI0YjkzNjJiYjRlNi4uMTMyMzExNjU5YTY3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcnRpbmEtYWNjZXNzLmMKKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3J0aW5hLWFjY2Vzcy5jCkBAIC03MSw3ICs3MSwxMSBAQCBz
dHJ1Y3QgY29ydGluYV91YXJ0X3BvcnQgewogc3RhdGljIHN0cnVjdCBjb3J0aW5hX3VhcnRfcG9y
dCAqY29ydGluYV91YXJ0X3BvcnRzOwogCiBzdGF0aWMgaXJxcmV0dXJuX3QgY29ydGluYV91YXJ0
X2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpOwotCitzdHJ1Y3QgY29ydGluYV91YXJ0
X3BvcnQgKmNvcnRpbmFfdWFydF9nZXRfcG9ydCh1bnNpZ25lZCBpbnQgaW5kZXgpOworI2lmZGVm
IENPTkZJR19TRVJJQUxfQ09SVElOQV9BQ0NFU1NfQ09OU09MRQordm9pZCBjb3J0aW5hX2NvbnNv
bGVfd3JpdGUoc3RydWN0IGNvbnNvbGUgKmNvLCBjb25zdCBjaGFyICpzLAorCQkJICAgdW5zaWdu
ZWQgaW50IGNvdW50KTsKKyNlbmRpZgogLyogUmV0dXJuIHVhcnRfcG9ydCBwb2ludGVyIGJhc2Ug
b24gaW5kZXggKi8KIHN0cnVjdCBjb3J0aW5hX3VhcnRfcG9ydCAqY29ydGluYV91YXJ0X2dldF9w
b3J0KHVuc2lnbmVkIGludCBpbmRleCkKIHsKLS0gCjIuMjAuMQoK

--_002_HK0PR01MB2499A2741A76C6610A20773CA20B9HK0PR01MB2499apcp_--
