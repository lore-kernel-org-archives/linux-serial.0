From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Tue, 20 Jan 2015 14:08:34 -0500
Message-ID: <54BEA7B2.2060708@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC3771.7030204@symas.com> <54BC5EC7.1090202@hurleysoftware.com> <54BCFC94.1040605@symas.com> <54BD1B53.9030901@hurleysoftware.com> <54BD328F.9090208@symas.com> <54BD567C.8070200@hurleysoftware.com> <54BD5E54.3050909@symas.com> <54BE9840.8080808@hurleysoftware.com> <54BEA0E0.9080807@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BEA0E0.9080807@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Chu <hyc@symas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>, linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On 01/20/2015 01:39 PM, Howard Chu wrote:
> Peter Hurley wrote:
>> On 01/19/2015 02:43 PM, Howard Chu wrote:

[...]

>> So it's really back to the question of, does allowing EXTPROC for regular
>> ttys have _value_?
> 
> Does preventing it have value?

Not that that is the appropriate metric for kernel behavior,
but yes, preventing it has value: it significantly limits
the matrix required for testing.


> I like having the option of turning linemode on and off in a session, for debugging purposes if nothing else.

... which is just as achievable with a pty-specific ioctl.

Regards,
Peter Hurley
