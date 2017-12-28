From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is used
Date: Thu, 28 Dec 2017 16:38:29 +0100
Message-ID: <CAOiHx==rL82D4NMz8t15jMr8m5oQmhkAzc+9r6qA0WMgbS-b9w@mail.gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com> <20171029152721.6770-4-jonas.gorski@gmail.com>
 <20171114110211.GA5823@jhogan-linux.mipstec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20171114110211.GA5823@jhogan-linux.mipstec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <james.hogan@mips.com>
Cc: MIPS Mailing List <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org

On 14 November 2017 at 12:02, James Hogan <james.hogan@mips.com> wrote:
> On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
>> Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
>> trigger I/F of FIFO buffers"), the port's default FCR value isn't used
>> in serial8250_do_set_termios anymore, but copied over once in
>> serial8250_config_port and then modified as needed.
>>
>> Unfortunately, serial8250_config_port will never be called if the port
>> is shared between kernel and userspace, and the port's flag doesn't have
>> UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.
>>
>> This causes garbled output from userspace:
>>
>> [    5.220000] random: procd urandom read with 49 bits of entropy available
>> ers
>>    [kee
>>
>> Fix this by forcing it to be configured on boot, resulting in the
>> expected output:
>>
>> [    5.250000] random: procd urandom read with 50 bits of entropy available
>> Press the [f] key and hit [enter] to enter failsafe mode
>> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
>>
>> Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers")
>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>> ---
>> I'm not sure if this is just AR7's issue, or if this points to a general
>> issue for UARTs used as kernel console and login console with the "fixed"
>> commit.
>
> Thanks. Given nobody seems to have objected, I've applied to my
> mips-fixes branch, with stable tag for 3.17+.

Hmm, I don't see it in
https://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git/log/?h=mips-fixes
- did you maybe forget to push?


Regards
Jonas
