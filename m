From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Tue, 20 Jan 2015 12:20:49 -0500
Message-ID: <54BE8E71.3080101@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC3771.7030204@symas.com> <54BC5EC7.1090202@hurleysoftware.com> <54BCFC94.1040605@symas.com> <54BD1B53.9030901@hurleysoftware.com> <54BD328F.9090208@symas.com> <54BD567C.8070200@hurleysoftware.com> <54BD69A4.4090705@symas.com> <54BE6BD9.4050403@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BE6BD9.4050403@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Chu <hyc@symas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>, linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On 01/20/2015 09:53 AM, Peter Hurley wrote:
> On 01/19/2015 03:31 PM, Howard Chu wrote:
>> Peter Hurley wrote:
>>> Ok.
>>> I might see if I can get telnet + a revised kernel interface to work together; I'll
>>> let you know if this works out.
>>
>> The patch here https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=585527#20 still applies cleanly to current Ubuntu netkit-telnet source and works.
> 
> Aw snap. I just quickly glanced at the patch and source, and assumed
> that the 4 year old patch had been applied.
> 
>> You'll have to use a dumb shell to see any effect.
> 
> I'm testing it now.

Yeah, canonical read() does not behave as it should if EXTPROC
is enabled; it's returning both multiple lines and unterminated lines.

Regards,
Peter Hurley
