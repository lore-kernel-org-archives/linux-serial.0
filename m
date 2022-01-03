Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9736C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jan 2022 10:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiACKaC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jan 2022 05:30:02 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:23192 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbiACKaB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jan 2022 05:30:01 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 05:30:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641205800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hw9WREfwS2llvvOAMvRAgxkl8/A5a/aViBDhm/P3cfo=;
        b=B2yAB0uVczYKqQIfd2ysl4SECxT6Fqanma8+o9dE47jZh4j5T/MuZymFw51tjLR+Sobl8N
        qMF9UoFnOz1n89p/5tzqmzaNaC3tNecp4Jd0+VCnemAxhesGOWlzt5Uxzzzc5mu3rXGSPk
        O1+XziCp0J9iHnxuoo/4p26Prs2EfsM=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2051.outbound.protection.outlook.com [104.47.21.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-275--CY8XhAmMkKwyhyZwjmLRA-1; Mon, 03 Jan 2022 10:22:43 +0000
X-MC-Unique: -CY8XhAmMkKwyhyZwjmLRA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWXP123MB5393.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 10:22:42 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 10:22:42 +0000
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        k.drobinski@camlintechnologies.com
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Subject: serial: imx: hardware flow control failure
Message-ID: <10e723c0-a28b-de0d-0632-0bd250478313@camlingroup.com>
Date:   Mon, 3 Jan 2022 11:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d0ef8be-2fd0-48e2-2472-08d9cea2fa02
X-MS-TrafficTypeDiagnostic: CWXP123MB5393:EE_
X-Microsoft-Antispam-PRVS: <CWXP123MB5393985ED13D82B65874893492499@CWXP123MB5393.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: O+uEOpRUb2EsRmce6GKc3TUOkF9jhv0KQz6dJZxcpSuz1jmCiTQkvKqJ/u2UcRmCVw+yQ0uoSUUhgS2PCaa8dBxy1iwktbCdEPrZiMEPYTM77MN/VIpr90sdtUL7fdzwvwhHM173vnIaf8KhNYUFL+UnL1CREz1xweNFl26jnaFQ09M6OMMGlGyt6iPV9acNKOTwMHUYmyzCPnUDahwtPcFgZOIKy7OokgN5vEuFBawAdHt9NTrqE3zdVeEEYM5ZfcWziBvfpTh2AyOT2zYfqDR30DtdGXRLcOlVKrImR0fcDJ2+MHhVu7gSq/OcNFYHQ+G+Ko3j9HfZvKs3O12XnGWI+gYz8QVnv36jmDoXH3EkeM3G+HqrjcGNVHfwU47CthZ6E6jimSkHdEIZse1c7V/BHJDIoCyGS/fAdf6BVBa3/j8kXkZ9BVkr8oNGD0W4KczNRLCRkl8NXDJVOeDGsh9mQKTv3aOk4wepPIzelWABHMUuo/L3QQvLLLF65pyE0Q118WapCbQD3mB8jP8G5KaPR8iF1rjiXvGPeM+4YjdU1I0tXRfoEoXGWZdaF3N6m/9W9AptfVKriuhU0LW8+ES96Rj1eT4H+BTCSc/w7r9MRqJ38Pa51kL00GdtgxXlgGmg740QybcnFO+nwA7no5IVR8BuqM9viIMigLiEqNp9xj8mrPUCcrgzrWxvzgDvSp5apdOheuIELZywkCWNitEU/FLghZ7YNTkVMbhjpmugKi6X3xq6ifp6LhixX8iWNXGiavhAsM20YETuSDchWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(66556008)(66476007)(66946007)(38100700002)(316002)(2616005)(83380400001)(107886003)(4326008)(186003)(31696002)(6512007)(5660300002)(86362001)(508600001)(6506007)(8676002)(38350700002)(31686004)(6916009)(54906003)(36756003)(2906002)(8936002)(52116002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRIZFRQUzd4Q2RWdzQ3Qk5kOTFLeXdEUEEyRXVpTzdQYUNzRVA3aERmcy9n?=
 =?utf-8?B?bVd0bnZZY1JIeWRkYWtrMDg5NEZUR0hpWCtDTEhRL3I4SkxwWFgwSmxHd25h?=
 =?utf-8?B?MEM5SjdrNDIyYm9MbGpxbGtTQk9wMktZcVpna1dHRXg4eERLa0ZNaFc3dFRP?=
 =?utf-8?B?TnUwZlQ4ODFWblYyRkJFQ09OZ2dQaVFZcjVma25kbHM5Y0tBR2ZFbnkra2I4?=
 =?utf-8?B?RWY4YkQwN2tIUW9MVnY2YzY5SDdUY2VQSysraTJkVVNOaGhPRzZCemVXcTEr?=
 =?utf-8?B?UFV3bElWRUErdVpaV3IvU3Q4UWRCWU5VSzRvUXZRVk5UOGcvMDZYYXIwM0pC?=
 =?utf-8?B?RjdGbFkvbElIb2N2a2UvcEJQbTBTMDdOUzRxakdlT09lZFJKdFdxNnI2ZG9t?=
 =?utf-8?B?WGgyZzEvQVNYOTBDQVkzWDBNUHB0ZjJLbWpZUUNTcm5FVENqeG9JQVNURlpW?=
 =?utf-8?B?YldRRGJzdExEMVk3WHBlZ0ZhaDAyMWloVVdaR2kzVUdGNVdLVWl6bmtzSHln?=
 =?utf-8?B?cVA4eXVhM0pJNUZ1QzR5QXlYRnNTd0dlTW92SjRibmRNVU1SZUVLZGYreFg2?=
 =?utf-8?B?dE1SaG9BZHlCZlNidDFMWVo4WDVJa1FkT3ZYVTlmV3YrbWdBTEl5RVkyY3cv?=
 =?utf-8?B?d3Ayb2d6anRLdm9OanZvWDl4d1crYW8vR1RHOTRhOFQ0TDNiQ0JZb2o5djNv?=
 =?utf-8?B?UU5sZUlQR21SZ0hjV2pkR1RrQXp4R2RBenhJQ1ludS8zeG5SL3pqZHZzK2VP?=
 =?utf-8?B?WXBTN3kzV2orU0o5VXFIMVFMbTNYOUNIcDJXMHF2QnNuM1Rsb0xYOEcxazBB?=
 =?utf-8?B?b3JsY2hsTk90ZFovQjN5WDJSdXRwN2FoR1Bvc0RGTUpvQVVkTE83bGNESWk5?=
 =?utf-8?B?d1Qyb3hIVWpsdEVmdXd3NlFXeUJQa2hXNlNJNVVZeDdWd2E2NjVKR2thVVY2?=
 =?utf-8?B?bkhqK2NiZGU1UXk5T3BPSENITlRJVjZuNEZsbWh3S0FZZkdnd3N4NnBLVWZQ?=
 =?utf-8?B?bjNBcDQrQ3RZV2psWHhIeXFra2dMazk1Wmk5UllkT05WWWNwcVlOQnA4dFMz?=
 =?utf-8?B?RGRLMDZoQ0VBcXJWR2d4aHBOcDRnaDBZVnllbkpxYUNFMWU2RW5XUWxpUUI4?=
 =?utf-8?B?RXU2RG1YaWt0K0JWL2lZWVFlUk5kVFJ5WEE3aHNzcit2eXFnRCtCOU9NT2tD?=
 =?utf-8?B?WXc5d1dsbkNyaG4vYjRKVjFBMWQvZ0ZxRnFaU2tXNDFNWFRMMGpveVdvd0dY?=
 =?utf-8?B?ZnlhVFBCOEhpOG9HRjJ5bTBSR1V5ZklJTktibzFXbXRMbmJ3MEJ5ZXZiTWZ3?=
 =?utf-8?B?OTlOc3podDBSL042Z3RsemRlYlZWV05VTVJQWWxEbWliTjMvRU80emZEempi?=
 =?utf-8?B?S1orWHJLKy83VGVEUGFBeG9qMU10L3VJVTMrZmFsUmJjZ1hJYzBrWnV3aE5o?=
 =?utf-8?B?cFRubHBrUElSMmZPOVNzck90MDh6U0lxbG5ERUNJQ1hOT2Rrc3ZiTlNabVd0?=
 =?utf-8?B?UHpRSk1CYllZMHVlYmg1SUEvbkNLbVdGMSs0VW9VaXZQOEJzYldXSzFLcDAy?=
 =?utf-8?B?eFlYbmU5MEViSFBwa3ZjaG1Nd3RDL204dVd6QWpUcXZpcFhLTWt0OU9mWjVF?=
 =?utf-8?B?WkZjVC9VaS9PVklLTTQ5VS9MK1Z1cDNKTlBxY20zazRqWVEva0IvdEIxb3ZP?=
 =?utf-8?B?dWR6ZjBIM04zVEhmLzNXNkhIU3hRTGxLOGhNdGU2SElCQkRobmhuT244WG9P?=
 =?utf-8?B?TmZEZWVEWDNxKzJWL1FxVFFpSk1WeEJVNXFnTFhxaU16cWpBaVZyNEtVd2Vi?=
 =?utf-8?B?K094RktDdFZPTFRWMFNXNVlnM1o2RCsxUHRKUkFPUURqVGJ5allsZDRHVStk?=
 =?utf-8?B?Z0ZzTGM1LzNtVllFaWNIU2NXeDY2NGdjN3pkTW52a3hCcXYyTzhlaGJxZjFO?=
 =?utf-8?B?MmdxVDRBWjBpdEFQaExuM3p6VCtYSHpMQ0tQN3d1WUFHVVV3cXNyZWNsMWU1?=
 =?utf-8?B?V0FXdmFjb0YxWk50THNWQVgxQmdWcys0Ums0b1BSTHNLR0VjZ091U2xCbWpO?=
 =?utf-8?B?dlVEcnF3anQvaG9aOTYwQm5HaDE3U3g0d2xNSHB4UVRIUjJUMDBDZHEzR3Fv?=
 =?utf-8?B?WHZBcGkzMEZvdy82NjhVbzF1SndBSXBCOXZqV3d2RWVYb3NWWlorVElvSWxS?=
 =?utf-8?B?ZWxDaTZmWThBZVUzRFpnWVhrMkNyQlRWMWc3VjZhbGxUdGtoNWxvcVJ3UTRD?=
 =?utf-8?B?bEtyS1NrL0IrRzI5akdUZHZMd0t3PT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0ef8be-2fd0-48e2-2472-08d9cea2fa02
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 10:22:42.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aMJ8cVsu8VvjLs3d2qAo7bTB5ZWCFhVB5R+0BpenVjBFWIkfOuH7c93MvKbeQmaBj+yc0gnO+TEaPalkZXLJQ7qilv4GpCta0R9kMcSI9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5393
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I am reliably able to trigger hardware flow control failure on imx7d
based system under following conditions:
  * two (or more) UARTs receive data simultaneously,
  * 1.5M baud, 8N1,
  * raw mode, CRTSCTS enabled,
  * "uart-has-rtscts" property present in devicetree,
  * DMA is disabled (no "dmas" nor "dma-names" in devicetree).

By hardware flow control failure I mean userspace application reading
from serial port device does not get all characters received by UART.

The sender is fully respecting RTS output (CTS_B) signal level. When
the failure occurs, the system appears frozen and unfreezes only when
the sender stops sending data.

Debugging led me to believe this is a starvation issue. I am not sure
what is the proper way to fix it.

Line discipline workqueue handler flush_to_ldisc() defined in
drivers/tty/tty_buffer.c is responsible for tty throttling. The call
stack when throttling is as follows:
  uart_throttle                  drivers/tty/serial/serial_core.c:681
  tty_throttle_safe              drivers/tty/tty_ioctl.c:147
  n_tty_check_throttle           drivers/tty/n_tty.c:264
  n_tty_receive_buf_common       drivers/tty/n_tty.c:1693
  n_tty_receive_buf2             drivers/tty/n_tty.c:1709
  tty_ldisc_receive_buf          drivers/tty/tty_buffer.c:471
  tty_port_default_receive_buf   drivers/tty/tty_port.c:39
  receive_buf                    drivers/tty/tty_buffer.c:491
  flush_to_ldisc                 drivers/tty/tty_buffer.c:543
  process_one_work               kernel/workqueue.c:2298
  worker_thread                  kernel/workqueue.c:2445

Unthrottling happens in read syscall handler:
  uart_unthrottle                drivers/tty/serial/serial_core.c:710
  tty_unthrottle_safe            drivers/tty/tty_ioctl.c:178
  n_tty_check_unthrottle         drivers/tty/n_tty.c:295
  n_tty_read                     drivers/tty/n_tty.c:2095
  iterate_tty_read               drivers/tty/tty_io.c:868
  tty_read                       drivers/tty/tty_io.c:944
  new_sync_read                  fs/read_write.c:400
  vfs_read                       fs/read_write.c:481
  ksys_read                      fs/read_write.c:619

The receive interrupt handler call stack is as follows:
  __imx_uart_rxint               drivers/tty/serial/imx.c:785
  imx_uart_int                   drivers/tty/serial/imx.c:961
  __handle_irq_event_percpu      kernel/irq/handle.c:158
  handle_irq_event_percpu        kernel/irq/handle.c:198
  handle_irq_event               kernel/irq/handle.c:215
  handle_fasteoi_irq             kernel/irq/chip.c:717
  handle_irq_desc                kernel/irq/irqdesc.c:646
  generic_handle_domain_irq      kernel/irq/irqdesc.c:680
  gic_handle_irq                 drivers/irqchip/irq-gic.c:372

While the imx UART has autoRTS feature, it is not effectively used by
Linux driver. That is, the feature itself (UCR2_CTSC bit) is enabled
when unthrottled, but the actual observable RTS output (CTS_B) changes
are the direct result of tty throttling/unthrottling.

During the failure, CPU is busy with receiving data from RxFIFO. Once
the flip buffer cannot store any more characters, the handler starts
dropping data (incrementing sport->port.icount.buf_overrun counter).
The CPU is fast enough to keep the RxFIFO level below the autoRTS
threshold (CTSTL in UCR4 register). To take the advantage of autoRTS,
all the CPU needs to do is stop reading from RxFIFO.

While the idea seems clear, converting it to code is not. I think the
tty flip buffer would need to expose mechanism to indicate if it can
store at least one more character *before* the rxint handler retrieves
it from the RxFIFO. If flip buffer cannot store any more characters,
the rxint handler would have to disable the receive interrupt to stop
the high CPU usage. But who should re-enable the receive interrupt?

When hardware flow control is achieved via RTS gpio, simply ceasing to
read from the RxFIFO is not enough. How to ensure that throttle will
happen as soon as possible? Would moving the rxint handler to tasklet
solve the issue?

What to do when the hardware flow control is not available? Should the
driver continue operating as-is, or should there be some mechanism to
prevent the rxint handler from effectively taking up all the CPU?

Best Regards,
Tomasz Mon

