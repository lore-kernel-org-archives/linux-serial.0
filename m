From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Q: what is the need for console write callback if there is serial
	tx (start_tx) ?
Date: Fri, 16 Sep 2016 10:11:00 +0300
Message-ID: <CAJ2oMhL2b9NmbtNBqDn2iE33KNVx+qCyCr2bHWXWZ4BnE1NLow@mail.gmail.com>
References: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
	<34480.1473972602@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <34480.1473972602@turing-police.cc.vt.edu>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: linux-serial@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 15, 2016 at 11:50 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Thu, 15 Sep 2016 23:19:51 +0300, Ran Shalit said:
>
>> Isn't writing to console, the same as outputing chars to serial ?
>
> No.  For instance, consider any laptop where "console" is an LCD screen,
> and if it's recent hardware, there isn't a UART anywhere in the device, nor
> is there a serial port to connect to.  Or any system where virtual terminals
> are in the config, for that matter.
>
> Then there's netconsole, console-over-USB, and heaven knows what other
> variations.
>
> See Documentation/console/console.txt  for more information.
>

Hi,

I seen in kernel tty drivers examples where there are both callback
for serial (start_tx, etc) , and for console (register_console).
I am not sure what reason for having a driver support both console and
serial. when there is serail it means there is a uart consoller,
according to my understand the console routine also implement put_char
with the same uart console (not graphic display for example), so it
seems like duplication. I am probably miss understand something.

Thanks you,
Ran
