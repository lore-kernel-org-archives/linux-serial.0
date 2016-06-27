From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 2/2] serial: sirf: make uart register info static
Date: Mon, 27 Jun 2016 10:25:52 +0100
Message-ID: <770f927c-1439-2313-e638-51cc85930d48@codethink.co.uk>
References: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
 <1465322772-26125-2-git-send-email-ben.dooks@codethink.co.uk>
 <20160625210150.GA3305@kroah.com> <8401626.hVVxvI31N9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8401626.hVVxvI31N9@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Barry Song <baohua@kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 25/06/16 22:07, Arnd Bergmann wrote:
> On Saturday, June 25, 2016 2:01:50 PM CEST Greg Kroah-Hartman wrote:
>> On Tue, Jun 07, 2016 at 07:06:12PM +0100, Ben Dooks wrote:
>>> The driver does not export the two structures that
>>> define the uart register mappings outside of the
>>> driver, so make them static to avoid the following
>>> warnings:
>>>
>>> drivers/tty/serial/sirfsoc_uart.h:124:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
>>> drivers/tty/serial/sirfsoc_uart.h:190:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?
>>>
>>> Note, we don't move these into the driver .c file as this would
>>> be a larger change. However they really should not belong in the
>>> header file like this.
>>
>> Please do the correct thing here and move them into the .c file.
> 
> I guess the entire sirfsoc_uart.h file can just get moved in there,
> nothing else includes it (obviously, as the symbols above would
> otherwise clash).

If no-one else objects then i'll sort a second revision.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
