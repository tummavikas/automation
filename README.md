
<h1>🛠️ Windows Dev Environment Setup Script</h1>

<p>This batch script automates the setup of essential developer tools on Windows: <strong>Winget</strong>, <strong>Git</strong>, and <strong>Python</strong>.</p>

<hr />

<h2>📂 How to Use</h2>

<h3>🔧 Step 1: Save the Script</h3>
<ol>
  <li>Open <strong>Notepad</strong> or any text editor.</li>
  <li>Paste the batch script content into the editor.</li>
  <li>Save the file with a <code>.bat</code> extension, such as <code>setup_env.bat</code>.</li>
</ol>
[![Watch the demo](https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg)]([https://www.youtube.com/watch?v=VIDEO_ID](https://youtu.be/NrCvil-JnR8))


<h3>🔐 Step 2: Run as Administrator</h3>
<ol>
  <li>Right-click on the saved <code>.bat</code> file.</li>
  <li>Select <strong>Run as administrator</strong> to allow system-level changes.</li>
</ol>

<hr />

<h2>⚙️ What This Script Does</h2>

<h3>✅ 1. Checks for Winget</h3>
<ul>
  <li>If Winget is missing, downloads and installs it silently.</li>
  <li>Cleans up installer after setup.</li>
</ul>

<h3>✅ 2. Checks for Git</h3>
<ul>
  <li>If Git is not found, installs it using Winget with silent flags.</li>
  <li>Attempts to add Git to the system PATH if necessary.</li>
</ul>

<h3>🧹 3. Removes Python Alias</h3>
<ul>
  <li>Removes Microsoft Store alias for <code>python.exe</code> to prevent conflicts.</li>
</ul>

<h3>✅ 4. Checks for Python</h3>
<ul>
  <li>Looks for Python in known directories.</li>
  <li>If not found, installs it using Winget silently.</li>
  <li>Updates the system PATH to include Python and Scripts folder.</li>
</ul>

<h3>🔁 5. Final Verification</h3>
<ul>
  <li>Checks installed versions of Git and Python.</li>
</ul>

<hr />

<h2>🧪 Output Example</h2>

<pre><code>✅ winget is available.
✅ Git is already installed.
✅ Python located at: C:\Users\&lt;user&gt;\AppData\Local\Programs\Python\Python3X
git version 2.xx.x.windows.x
Python 3.x.x
</code></pre>

<hr />

<h2>🔄 After Running</h2>
<p>Restart your terminal or IDE to apply the updated environment variables.</p>

<hr />

<h2>📃 License</h2>
<p>MIT — Use and distribute freely with proper attribution.</p>
