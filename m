Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFAEC636CA
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9A26128C
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGQMrq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhGQMrp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 08:47:45 -0400
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [IPv6:2001:638:a01:1096::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D63C06175F;
        Sat, 17 Jul 2021 05:44:48 -0700 (PDT)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S03", Issuer "E16S03" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4GRnqw2sPQzxxM;
        Sat, 17 Jul 2021 14:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1626525884;
        bh=DObdPEz8dc9fpgzhCh0TXIKplWQjWy3yuMi0S8nVwn0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Atwzcr1LfwKQOLIsRwfQKHCtxICogZrce/pO56aFJR5Gvy/3z2X+3J/wPY9WtBaAm
         CjV2iMk3Ev34F4KTeC4bzRcvshIaJVv8SOnf+Vb0hp+qm9jM6fFlL7AH0J37ddRuMh
         DgCgAXUiOGEbj3CHwc7GH+ZL1Eg7RlEpW1ZYKeB+UdBIfBc3E47clmot3uglsmy8ij
         qFLlvQMSuCvOlNREXXvzk3R/YMSQXq4Sk0rXQVJG63ZT9wDhhWg9wfydUkIgL5lbTC
         Hnki53ZCd8XjuBE6tExAzLSC/ycetejhLz+G5301r/RnKOMx5ytaDG8ahAjecjY6vv
         6PRbDMd3J52pg==
Received: from [IPv6:2001:678:ddc:11:17a4:3bb5:620b:1dcb]
 (2001:638:a01:8013::138) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sat, 17 Jul
 2021 14:44:43 +0200
Subject: Re: [EXT] Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
 <784629f9-677e-ee53-aceb-89397ce0951a@oth-regensburg.de>
 <CAHp75VdoaE7hCOzsRvuf=7A4mmv0NWBmwqK_mM8vO-K3YZKTUQ@mail.gmail.com>
 <ac8ac10e-aa43-93a1-d36e-6304643375ae@oth-regensburg.de>
 <CAHp75VcLicxAz5BjP+Lp2yHxEGiKcT9OUZbPeRUgZVcYLdY0FA@mail.gmail.com>
 <599a37bd-3cb4-1e4b-d5f8-936c4daae71f@oth-regensburg.de>
 <YPHBhpfk8RoEuQx2@smile.fi.intel.com>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Message-ID: <447b30df-cb9e-cfaf-6381-0a1c426fa57c@oth-regensburg.de>
Date:   Sat, 17 Jul 2021 14:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPHBhpfk8RoEuQx2@smile.fi.intel.com>
Content-Type: multipart/mixed;
        boundary="------------22358B651524AC6FC03F8265"
Content-Language: en-US
X-Originating-IP: [2001:638:a01:8013::138]
X-ClientProxiedBy: E16S01.hs-regensburg.de (2001:638:a01:8013::91) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--------------22358B651524AC6FC03F8265
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 16/07/2021 19:27, Andy Shevchenko wrote:
> On Fri, Jul 16, 2021 at 05:27:36PM +0200, Ralf Ramsauer wrote:
>> On 16/07/2021 17:01, Andy Shevchenko wrote:
>>> On Fri, Jul 16, 2021 at 4:07 PM Ralf Ramsauer
>>> <ralf.ramsauer@oth-regensburg.de> wrote:
>>>> On 14/07/2021 15:35, Andy Shevchenko wrote:
>>>>> On Wed, Jul 14, 2021 at 3:56 PM Ralf Ramsauer
>>>>> <ralf.ramsauer@oth-regensburg.de> wrote:
>>>>>> On 14/07/2021 08:54, Jiri Slaby wrote:
>>>>>>> On 13. 07. 21, 12:40, Andy Shevchenko wrote:
>>>>>
>>>>>>> Hmm, have you checked the commit which introduced the whitelist?
>>>>>>>
>>>>>>>     Nevertheless, this needs to handled with care: while many 8250 devices
>>>>>>>     actually claim to support MSI(-X) interrupts it should not be
>>>>>>> enabled be
>>>>>>>     default. I had at least one device in my hands with broken MSI
>>>>>>>     implementation.
>>>>>>>
>>>>>>>     So better introduce a whitelist with devices that are known to support
>>>>>>>     MSI(-X) interrupts. I tested all devices mentioned in the patch.
>>>>>>>
>>>>>>>
>>>>>>> You should have at least CCed the author for an input.
>>>>>>
>>>>>> Yep, back then I was testing three different 8250 pci cards. All of them
>>>>>> claimed to support MSI, while one really worked with MSI, the one that I
>>>>>> whitelisted. So I thought it would be better to use legacy IRQs as long
>>>>>> as no one tested a specific card to work with MSI.
>>>>>
>>>>> Can you shed a light eventually what those cards are?
>>>
>>>> So I found a no-name el-cheapo card that has some issues with MSI:
>>>
>>> Win Chip Head (WCH)
>>>
>>>> 18:00.0 Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])
> 
> Thank you!
> 
> One more thing, ist it possible to see entire PCI configuration space (w/ or
> w/o MSI, I don't think it matters)? Something like
> 
> 	`lspci -nk -vvv -xxx -s 18:0`
> 
> to run.
> 
> (I believe there are a lot of 0xff bytes)

Find it attached, w/ MSI+. Not that many, only the 0xffs for the MSI
mask, afaict.

  Ralf

--------------22358B651524AC6FC03F8265
Content-Type: text/plain; charset="UTF-8"; name="18.0.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="18.0.txt"

MTg6MDAuMCAwNzAwOiAxYzAwOjMyNTMgKHJldiAxMCkgKHByb2ctaWYgMDUgWzE2ODUwXSkK
CVN1YnN5c3RlbTogMWMwMDozMjUzCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBT
cGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBh
ckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQ
RVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJR
IDEwNAoJTlVNQSBub2RlOiAwCglSZWdpb24gMDogSS9PIHBvcnRzIGF0IDQwMDAgW3NpemU9
MjU2XQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBhYjAwMDAwMCAoMzItYml0LCBwcmVmZXRjaGFi
bGUpIFtzaXplPTMyS10KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgNDEwMCBbc2l6ZT00XQoJ
RXhwYW5zaW9uIFJPTSBhdCBhYjIwMDAwMCBbZGlzYWJsZWRdIFtzaXplPTMyS10KCUNhcGFi
aWxpdGllczogWzYwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVD
bGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDEtLEQyLSxEM2hv
dCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0w
IERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzY4XSBNU0k6IEVuYWJsZSsgQ291bnQ9
MS8zMiBNYXNrYWJsZSsgNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDBiOCAgRGF0
YTogMDAwMAoJCU1hc2tpbmc6IGZmZmZmZmZmICBQZW5kaW5nOiAwMDAwMDAwMAoJQ2FwYWJp
bGl0aWVzOiBbODBdIEV4cHJlc3MgKHYyKSBMZWdhY3kgRW5kcG9pbnQsIE1TSSAwMAoJCURl
dkNhcDoJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8
MnVzLCBMMSA8MzJ1cwoJCQlFeHRUYWctIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJF
KyBGTFJlc2V0LQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnIrIEZhdGFsRXJyKyBV
bnN1cFJlcSsKCQkJUmx4ZE9yZCsgRXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9v
cCsKCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2
U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3Ir
IFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIuNUdUL3MsIFdpZHRoIHgx
LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRl
ZAoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcC0K
CQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1D
bGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0K
CQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKG9rKSwgV2lkdGggeDEgKG9rKQoJCQlUckVyci0g
VHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjog
Q29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzKyBOUk9QclBy
UC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9y
dGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24g
Tm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLQoJ
CQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBD
b21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSBPQkZG
IERpc2FibGVkLAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtDdGwyOiBUYXJnZXQg
TGluayBTcGVlZDogMi41R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRy
YW5zbWl0IE1hcmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENv
bXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAt
NmRCCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBMZXZlbDogLTZkQiwgRXF1YWxp
emF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBo
YXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJ
IFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJp
bGl0aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQ
LSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0g
TWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0g
VExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQrIFJ4T0YtIE1hbGZUTFAt
IEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sKwoJCVVFU3ZydDoJRExQKyBTREVTLSBUTFArIEZD
UCsgQ21wbHRUTysgQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQysg
VW5zdXBSZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJv
bGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0KCQlDRU1zazoJUnhFcnIrIEJhZFRM
UCsgQmFkRExMUCsgUm9sbG92ZXIrIFRpbWVvdXQrIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNh
cDoJRmlyc3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXArIEVDUkNHZW5FbisgRUNS
Q0Noa0NhcCsgRUNSQ0Noa0VuKwoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRM
UFBmeFByZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogc2VyaWFsCglLZXJuZWwg
bW9kdWxlczogODI1MF9wY2kKMDA6IDAwIDFjIDUzIDMyIDA3IDA0IDEwIDAwIDEwIDA1IDAw
IDA3IDAwIDAwIDAwIDAwCjEwOiAwMSA0MCAwMCAwMCAwOCAwMCAwMCBhYiAwMSA0MSAwMCAw
MCAwMCAwMCAwMCAwMAoyMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMWMgNTMgMzIKMzA6IDAwIDgwIGZmIGZmIDYwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZm
IDAxIDAwIDAwCjQwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMAo1MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKNjA6IDAxIDY4IGMzIGM5IDAwIDAwIDAwIDAwIDA1IDgwIDhiIDAxIGI4IDAwIGUw
IGZlCjcwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBmZiBmZiBmZiBmZiAwMCAwMCAwMCAw
MAo4MDogMTAgMDAgMTIgMDAgNDEgOGIgNjQgMDAgM2UgMjggMTAgMDAgMTEgZmMgMDcgMDAK
OTA6IDQwIDAwIDExIDEwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmEw
OiAwMCAwMCAwMCAwMCAxMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApiMDog
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKYzA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmQwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAplMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKZjA6IDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCgo=
--------------22358B651524AC6FC03F8265--
