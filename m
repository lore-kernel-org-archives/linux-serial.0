From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: Does braille console work?
Date: Fri, 17 Mar 2017 12:00:02 +0300
Message-ID: <6657242f-e4a9-f142-a6eb-f0c07a7d04f3@gmail.com>
References: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
 <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/17/2017 03:53 AM, Samuel Thibault wrote:
> Hello,
> 
> Aleksey Makarov, on jeu. 16 mars 2017 17:02:53 +0300, wrote:
>> There can be 3 outcomes from this function:
>> 1) it returns NULL and does not set brl_options
>> 2) it returns NULL and set the variable pointed by str to NULL
>> 3) it returns non-NULL
> 
> Uh, that's odd indeed, the intent was that it'd return an error code
> only.
> 
>> To register a braille console (i. e. to call __add_preferred_console()
>> with non-NULL brl_options) function _braille_console_setup() should
>> return NULL and initialize brl_options. 
> 
> return 0 (as in no error), actually, in the intent.
> 
>> 1) in this case brl_options is NULL and non-braille console is registered
>> 2) kernel produces oops later in console_setup().  I reproduced it
>>    passing "console=brl=aaa" parameter to kernel, see below.
>> 3) no console is registered
>>
>> So braille console registration should not work.  What do I miss?
> 
> Nothing, the code transformation was broken :/

So the kernel contains seemingly unmaintained code that does not work
for at least 3 years.  Its parts in printk.c considerably complicate
code support.

>> So it looks like braille console has not been used for more than 3 years.
>> Should we remote it?
> 
> Please, no :)
> 
> It is indeed not often useful, since one would usually use a userland
> daemon to access the system, but when one's system does not boot
> properly or something similar, it's useful to have the braille
> console. That's just very not often useful.

Why should we keep the code which does not work?  And which is used
more than 3 years ago and usage requires patching.
I think removing it is a good idea

Thank you
Aleksey Makarov

> Samuel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
