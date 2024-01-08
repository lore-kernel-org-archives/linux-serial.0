Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2112.outbound.protection.outlook.com [40.107.101.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615A54F83
	for <linux-serial@vger.kernel.org>; Mon,  8 Jan 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="a8ndnx3z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnLLxkKuiLNihl0zUHiZN1VOQjYbS4D6W49pK7meAZy+rY5znxjCRDl6fInW4Lnx23MKCjjVknz0ZKqJiylK8NV3DuE915eQD+aIA036oF3gMMk7zvAEhIRRT+bWlI4UnJeQZCAmunienD7VwR2rlph65YtMBgIUFjG0FMDxQRKZ7fevZGQdy+JKj+QHU9xUJgQWRUHV6KnGW3ke5yrO3Dc1EWha4td54aZm/K9HiCxCmxa7Etm6GQCTikpQUF8scxNhae3W16Yae0+sIa0GaUlzZbWYxF8zGWCRiYfhM9PbkG8VzJ6vOAqboC/ToByi1f/Ixiv+Hj8cklqpxDj8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etZzBbBt5HjEal/APW09QF0uCzwHxU7RTfRFTFYExaE=;
 b=LDKHJS0de1zbyzL3Y7w23gNNAwO7WViMbuDVvncovhvuyjAFiuA3KLjQG3QAU66pmcUDTWckukVdEIBfHY6GRgICXwPu0OFGPBDkaJC4gwtuzyFAHwTYIx34vbDzLV6c6mAMh+H415y6aJtC/ll5L0YueCg4fwtKJAMG3IQIEaBUJHBENPl80VMpxQO+jnbm9M060AqpJK5l0gSVKFt36xA66Ce3InRuiB0VZrMrHI3WJGQgeP0Q6n2c909uILENJichm+vBAcysta/gQOhLBdkSv+PUSPDwRneEJL4DlvO8R7E/07Eeyy7AKoEv3EQUQ73hAfz1gCHHM6v4Gqc3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etZzBbBt5HjEal/APW09QF0uCzwHxU7RTfRFTFYExaE=;
 b=a8ndnx3zjzXa9ZABoq16V1UYsoWww4ue3duCpO0HIS2gEIrNk8QG0JLy5caSxzvGzqsBacXluJPB6S9LMM2Y6gN9tODwJLEA5HBH3Ri/2IrdIKOez/m2PcT/LBPtxN2xjYrbkd6RHQjj3CDNxnqM0QXd/KzPvK5e5CsYyTTmWS4Jx35Rn01KG5hvaYPKb1/WT0evZQ2Lrf+DYlKWY6PrW1rTgiuZ33h+reSmTr0T1kcGxCo2X1vTvzPrn0CqmJrCllY8p89hhD4xFwPm6GZAC0jLiR9MHfZqa53l4vBKyPbAmzAu5or0lU+sLMVpA9db4/QLLFen2l3yGHYs+UTqzQ==
Received: from DM4PR01MB7595.prod.exchangelabs.com (2603:10b6:8:5e::22) by
 PH0PR01MB8118.prod.exchangelabs.com (2603:10b6:510:29c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Mon, 8 Jan 2024 19:08:08 +0000
Received: from DM4PR01MB7595.prod.exchangelabs.com
 ([fe80::6878:c4a4:24f7:4e5d]) by DM4PR01MB7595.prod.exchangelabs.com
 ([fe80::6878:c4a4:24f7:4e5d%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 19:08:08 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: max14830 irq
Thread-Topic: max14830 irq
Thread-Index: AdpCZgM5EpVKR9TvQJaVhp41Fise0g==
Date: Mon, 8 Jan 2024 19:08:08 +0000
Message-ID:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
Reply-To: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR01MB7595:EE_|PH0PR01MB8118:EE_
x-ms-office365-filtering-correlation-id: e1751acd-a46a-4fe4-c347-08dc107d267a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 whSK6w4eZ64Ycm4EKst9Yomsu99WVWY8q0PHm14agxJqXnsmFOEkhGmuCO8Y4EIOy9V9tl4ugPf0U8E4ovHTNOFFyD2rPhO+bmC0MB/mZto6toxtWLjlS8Hc+5KE7rZk1bwnWN7LjaQ4kWZty8tbEGRJugbdm+1jD7WRkzqcZ7F9agSuaNWTxJ+nCVgSQXJ6e6X4TgJPrGexqjYwEqv/aczA/1G4SMD/alpWg0mO27rziw2J3+fvF+I2xmZff0IaBAtwamN1eJwJEWP54g7bqhe07/1XRNBKly0m8AvPiK3CzzRA+dBgGoyfgTF7SeeLcLqxRYyuDCi8DADCQfY/Aih8SoCQnKtBGwtBh+gqLUz9VmXOLMI7JMjuIRcUovBuvvYoPivhVtt2qT1Slq2BpMk8kSpECblU76a8dyRyqKoQL/f2yVGzhljsPy4utgiwV3Q2RWLXFFe/jbiy5SdmXlDx8mv9nux8yWhmeSf9EMlGdxfcqii0CnIPZoddMx9yDMH5esyzxBA5XKndWtQkqQJFCwoLlXY8NUTxolZHZVHb3EXTFkXFq0xnLVb5M1JNP4GIC2/od0CPvvg2kPgBpQmVGHMS9rKMDRqgLF6uWw26f5ox2tKG7Rn07T7RagTkSBEvFtptCGXsaCpJqKGAA3E9aCoo0Vs/xrZYxwkA9kQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR01MB7595.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(396003)(136003)(346002)(366004)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(6506007)(9686003)(478600001)(71200400001)(7696005)(5660300002)(66476007)(66946007)(83380400001)(41300700001)(7116003)(2906002)(316002)(76116006)(6916009)(3450700001)(52536014)(8936002)(66556008)(8676002)(64756008)(66446008)(38070700009)(38100700002)(86362001)(122000001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+KEEndjdpEhR/Cwwzao35FQA2aVM7EBuGS1Gc5OD9sN9VtW344VBjPOyKDxX?=
 =?us-ascii?Q?0vQV+G4fKUBsm9EwiotnARJJXipg1XyRyOSKFs0oEfT+TfY3OQmt6tQrSpNh?=
 =?us-ascii?Q?oL+vvdMi1KhSSoLl0/mA0vLd/PopZClp4qMNuMYfOZJLkeIfnfSiIsi8HmD/?=
 =?us-ascii?Q?8Zj36IxpdkG3ZgGOYRYWrkMqKotEOF1l1EOyOJmNt+MgvKkQkqtUT2quTmic?=
 =?us-ascii?Q?OYrq1Lko762HtcygC4DAZlqkW6+wP/8C/My5zjxJZiRNFlJhTF7+m/PmsfCh?=
 =?us-ascii?Q?b6gZbQS9YLeEG4tKwcSkvIS5t5dYEh05jjr7U0KX88avBR5khfljDJy0J3Q7?=
 =?us-ascii?Q?waNJwMSecA2BGSlftK79dyYaZZXNATJfCAtwbEDFZppkExcgm68rqF/Sfv6p?=
 =?us-ascii?Q?aJGn6DQGRL4S5tAQc7W9yJSfEE8SpShtyAN7LF9skKlWSz06c2EZHSRjxLiT?=
 =?us-ascii?Q?QAo61TJfnhj5//wB0wVcYNKn29bQ1RziBtErg4adMWPbBoILR6+Rogu0mqIn?=
 =?us-ascii?Q?J/3m7+X1p7eR7XLBSsvOTxGN4imPNZrgvxokF8zgjusyFOwLn96BZ1P8HDjY?=
 =?us-ascii?Q?LTj0aG31kMdZJxvP4eBjS9TC5QxiP78daLsWjAZ1Yb1rjIes1zuYoeZHQfX4?=
 =?us-ascii?Q?IiXW6bjk2zq0tZltsuLyU/0lUYqvZfsTBbUWSCJIduTmpvXaxioQFxwgrROM?=
 =?us-ascii?Q?yWB2yBnKPN3rqCUSVpe5b2oKZYBycf27mZf3pjSO+lzU8V1lj8va+j7gd7jB?=
 =?us-ascii?Q?PZZBcPLBzuUYS10rHHVl5gKc5HFt8jDyRuXwuA+bDqiwWzSYHHB6mO9PIcPz?=
 =?us-ascii?Q?YqcoV/nh6cSdHGiZwY3YA+7UuUgRbUQGbSdXeMMD3uNtUy3SLXyQh9avaPhP?=
 =?us-ascii?Q?ty2XhqghKXwL5sjhUOrW6LI9fWbeHjEqKXq2XidwQorq2IQ9FzQNMIsBtGQh?=
 =?us-ascii?Q?3twyXElgzHmNOsvO0NBNo7KXwT0ck3+zapOLkZcGqQPdKhz/XEVUVQ3Uu1j3?=
 =?us-ascii?Q?yoFT7AMZS2a6kPrwzjxi+jdn+ugCHMy04dv4gMiWqhvDbSGAGTZHoYVx+WEt?=
 =?us-ascii?Q?V1iezQWQQQTp+bvMSj2ZVA8NInF6ixV8QNWL43vARRaArEvIzop63dDLklT/?=
 =?us-ascii?Q?5mEQ52xVF/YWUCtrFD1zqjUawZTqJHLggQOPY2v48rhEmXvXvlN1ckb60csk?=
 =?us-ascii?Q?ROniHe4yY7goFzZP6q4wwDUi0vPNyC8DBiyw3erJS9KBAWHKHSeAHYflohIL?=
 =?us-ascii?Q?6kaT8BwAsu6OwhBeLqhGXMvcj7SjafNtK65dyOSURRrwa4M0QaUEMkoDSFOS?=
 =?us-ascii?Q?EUr7ZcNhwWf4HPtoczOG6cFB2n/Tfg6maMAO1gIXsS5bFlbXHnA7QXf+kFRh?=
 =?us-ascii?Q?LzGXlO7F2ULH9GMcuOHNu2ev6RcWa86CbPdJ+P9hv+ouk1o+77QJHa3/7v2c?=
 =?us-ascii?Q?qXUGvNKF0LKJD4BCIbwDPXfBoBBtxWvUXjWpRJg2lKJ1F+R0aytavCkOCN2q?=
 =?us-ascii?Q?n6QfO60rWuCiad46JrPvHFxKvOgtD+pb6qiib5fBqzPxmigAbkfmsuhZ9XuA?=
 =?us-ascii?Q?RXI3IF2QRokSdiMfkZ9S0fSULfpa3CbNayM4oX2vSLhae53fxLOJU7yu9JBT?=
 =?us-ascii?Q?FrUFV6yPp76YPk6VJmo7rU7kXiIdvM+OFgPjZWmmqjSRsewAHcgjuoebzmjC?=
 =?us-ascii?Q?xHl4cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR01MB7595.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1751acd-a46a-4fe4-c347-08dc107d267a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 19:08:08.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqKqORMK0oN7cCnnjk2kt64TnolevkwtjuLbvnGe8AHEcfCR0lI6nsoJVkXkBtBzsSU4+9hgM7+PxZZnNMUrsRRQSRxnkeSEcT5J2ay+fuyNHFQvUToV3JIhVKkOUu/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8118

Hello,
I am trying to get max14830 working on our platform and I'm seeing a stack =
trace for each of the UARTs in my device tree.  I'm not sure what the fix i=
s.  I'm running 6.1.15-580639a (OpenBMC 2.14.0) on ASPEED ast2600.  Any hel=
p appreciated.
[    2.608620] max310x 11-006c: clock is not stable yet
[    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq =3D 57, base_baud =3D 37500=
00) is a MAX14830
[    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq =3D 57, base_baud =3D 37500=
00) is a MAX14830
[    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq =3D 57, base_baud =3D 37500=
00) is a MAX14830
[    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq =3D 57, base_baud =3D 37500=
00) is a MAX14830
And,
[   88.430219] irq 57: nobody cared (try booting with the "irqpoll" option)
[   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted 6.1.15-58063=
9a #1
[   88.445687] Hardware name: Generic DT based system
[   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
[   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
[   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
[   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x314
[   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
[   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1b4
[   88.487952]  handle_level_irq from generic_handle_domain_irq+0x30/0x40
[   88.495253]  generic_handle_domain_irq from aspeed_gpio_irq_handler+0xac=
/0x158
[   88.503326]  aspeed_gpio_irq_handler from generic_handle_domain_irq+0x30=
/0x40
[   88.511305]  generic_handle_domain_irq from gic_handle_irq+0x6c/0x80
[   88.518411]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
[   88.525316]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
[   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
[   88.543614] 5ea0:                                     45854088 00000003 =
00000001 00000000
[   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000 45854000 41a64140 =
00000000 00000000
[   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f0013 ffffffff
[   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
[   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
[   88.581714]  __wake_up from irq_thread+0x118/0x1ec
[   88.587070]  irq_thread from kthread+0xd8/0xf4
[   88.592040]  kthread from ret_from_fork+0x14/0x2c
[   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
[   88.602923] 5fa0:                                     00000000 00000000 =
00000000 00000000
[   88.612053] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[   88.621179] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   88.628559] handlers:
[   88.631088] [<4f379e2c>] irq_default_primary_handler threaded [<26199d83=
>] max310x_ist
[   88.639952] Disabling IRQ #57

__________________________
Usha Srinivasan



External recipient
