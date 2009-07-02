From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Alsa mixer over serial port
Date: Thu, 2 Jul 2009 14:32:21 +0100
Message-ID: <20090702133220.GA22321@sirena.org.uk>
References: <4A4CB5CF.2020703@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4A4CB5CF.2020703@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 02, 2009 at 03:27:43PM +0200, Janusz Krzysztofik wrote:

> I can see two ways of getting this working:
> 1) add a new line discipline that would take control over the serial 
> line and convert it to an alsa mixer,
> 2) create a low level driver that would replace standard serial stuff 
> completely (like snd-serial-u16550 does, for example).

> Please advise which one is better.

ASoC doesn't really care for itself - it just needs the upper layer
interface, how exactly the driver ineteracts with the device is not
important to ASoC.
