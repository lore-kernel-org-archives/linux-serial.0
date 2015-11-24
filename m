From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
Date: Tue, 24 Nov 2015 08:26:23 +0100
Message-ID: <5654111F.3000509@xilinx.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
 <20151120165804.GV32017@xsjsorenbubuntu>
 <564F5574.4070407@hurleysoftware.com> <5652BAD2.4090000@xilinx.com>
 <56537054.6090208@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56537054.6090208@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 23.11.2015 21:00, Peter Hurley wrote:
> Hi Michal,
> 
> On 11/23/2015 02:05 AM, Michal Simek wrote:
>> All these tests looks very interesting. Do you have any any
>> work-in-progress repo with other tests? It will be good to run all of
>> them to validate our drivers.
> 
> I haven't upstreamed these yet, but I plan to do so soon, along with
> tty core, pty, n_tty i/o, termios, and torture tests and some basic tools.

great. Can you please keep me in the loop?

Thanks,
Michal
