From: Howard Chu <hyc@symas.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Tue, 20 Jan 2015 18:51:15 +0000
Message-ID: <54BEA3A3.9000407@symas.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC3771.7030204@symas.com> <54BC5EC7.1090202@hurleysoftware.com> <54BCFC94.1040605@symas.com> <54BD1B53.9030901@hurleysoftware.com> <54BD328F.9090208@symas.com> <54BD567C.8070200@hurleysoftware.com> <54BD5E54.3050909@symas.com> <54BE9840.8080808@hurleysoftware.com> <54BEA0E0.9080807@symas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020302060800040504050302"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BEA0E0.9080807@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>, linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302060800040504050302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Howard Chu wrote:
> Peter Hurley wrote:
>> On 01/19/2015 02:43 PM, Howard Chu wrote:
>>> The fact that EXTPROC can be manually unset is by design. Quoting
>>> from the original again:
>>>
>>>> stty.diff:
>>>>      This file contains the changes needed for the stty(1) program
>>>>      to report on the current status of the TS_EXTPROC bit.  It also
>>>>      allows the user to turn on/off the TS_EXTPROC bit.  This is useful
>>>>      because it allows the user to say "stty -extproc", and the
>>>>      LINEMODE option will be automatically disabled, and saying "stty
>>>>      extproc" will re-enable the LINEMODE option.
>>
>> This option is not supported by gnu coreutils.
>
> OK. It's in *BSD and Minix. Looks like I never wrote a patch for
> coreutils for this last time around.

Wrote it, just never submitted it.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/

--------------020302060800040504050302
Content-Type: text/plain; charset=UTF-8;
 name="dif.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dif.txt"

LS0tIHN0dHkuYwkyMDA5LTA0LTI0IDEzOjQxOjE5LjAwMDAwMDAwMCArMDEwMAorKysgLi4v
Li4vLi4vY29yZXV0aWxzLTcuNC9zcmMvc3R0eS5jCTIwMTAtMDYtMTcgMDY6NDg6NDIuMDAw
MDAwMDAwICswMTAwCkBAIC0zMzAsNiArMzMwLDkgQEAKICAgeyJlY2hva2UiLCBsb2NhbCwg
U0FORV9TRVQgfCBSRVYsIEVDSE9LRSwgMH0sCiAgIHsiY3J0a2lsbCIsIGxvY2FsLCBSRVYg
fCBPTUlULCBFQ0hPS0UsIDB9LAogI2VuZGlmCisjaWZkZWYgRVhUUFJPQworICB7ImV4dHBy
b2MiLCBsb2NhbCwgU0FORV9VTlNFVCB8IFJFViwgRVhUUFJPQywgMH0sCisjZW5kaWYKIAog
ICB7ImV2ZW5wIiwgY29tYmluYXRpb24sIFJFViB8IE9NSVQsIDAsIDB9LAogICB7InBhcml0
eSIsIGNvbWJpbmF0aW9uLCBSRVYgfCBPTUlULCAwLCAwfSwK
--------------020302060800040504050302--
